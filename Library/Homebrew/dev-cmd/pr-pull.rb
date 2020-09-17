# frozen_string_literal: true

require "download_strategy"
require "cli/parser"
require "utils/github"
require "tmpdir"
require "formula"

module Homebrew
  module_function

  def pr_pull_args
    Homebrew::CLI::Parser.new do
      usage_banner <<~EOS
        `pr-pull` [<options>] <pull_request> [<pull_request> ...]

        Download and publish bottles, and apply the bottle commit from a
        pull request with artifacts generated by GitHub Actions.
        Requires write access to the repository.
      EOS
      switch "--no-publish",
             description: "Download the bottles, apply the bottle commit and "\
                          "upload the bottles to Bintray, but don't publish them."
      switch "--no-upload",
             description: "Download the bottles and apply the bottle commit, "\
                          "but don't upload to Bintray or GitHub Releases."
      switch "-n", "--dry-run",
             description: "Print what would be done rather than doing it."
      switch "--clean",
             description: "Do not amend the commits from pull requests."
      switch "--keep-old",
             description: "If the formula specifies a rebuild version, " \
                          "attempt to preserve its value in the generated DSL."
      switch "--autosquash",
             description: "Automatically reformat and reword commits in the pull request to our "\
                          "preferred format."
      switch "--branch-okay",
             description: "Do not warn if pulling to a branch besides master (useful for testing)."
      switch "--resolve",
             description: "When a patch fails to apply, leave in progress and allow user to resolve, "\
                          "instead of aborting."
      switch "--warn-on-upload-failure",
             description: "Warn instead of raising an error if the bottle upload fails. "\
                          "Useful for repairing bottle uploads that previously failed."
      flag   "--message=",
             depends_on:  "--autosquash",
             description: "Message to include when autosquashing revision bumps, deletions, and rebuilds."
      flag   "--workflow=",
             description: "Retrieve artifacts from the specified workflow (default: `tests.yml`)."
      flag   "--artifact=",
             description: "Download artifacts with the specified name (default: `bottles`)."
      flag   "--bintray-org=",
             description: "Upload to the specified Bintray organisation (default: `homebrew`)."
      flag   "--tap=",
             description: "Target tap repository (default: `homebrew/core`)."
      flag   "--root-url=",
             description: "Use the specified <URL> as the root of the bottle's URL instead of Homebrew's default."
      flag   "--bintray-mirror=",
             description: "Use the specified Bintray repository to automatically mirror stable URLs "\
                          "defined in the formulae (default: `mirror`)."
      min_named 1
      conflicts "--clean", "--autosquash"
    end
  end

  def setup_git_environment!
    # Passthrough Git environment variables
    ENV["GIT_COMMITTER_NAME"] = ENV["HOMEBREW_GIT_NAME"] if ENV["HOMEBREW_GIT_NAME"]
    ENV["GIT_COMMITTER_EMAIL"] = ENV["HOMEBREW_GIT_EMAIL"] if ENV["HOMEBREW_GIT_EMAIL"]

    # Depending on user configuration, git may try to invoke gpg.
    return unless Utils.popen_read("git config --get --bool commit.gpgsign").chomp == "true"

    begin
      gnupg = Formula["gnupg"]
    rescue FormulaUnavailableError
      nil
    else
      if gnupg.any_version_installed?
        path = PATH.new(ENV.fetch("PATH"))
        path.prepend(gnupg.any_installed_prefix/"bin")
        ENV["PATH"] = path
      end
    end
  end

  # Separates a commit message into subject, body, and trailers.
  def separate_commit_message(message)
    subject = message.lines.first.strip

    # Skip the subject and separate lines that look like trailers (e.g. "Co-authored-by")
    # from lines that look like regular body text.
    trailers, body = message.lines.drop(1).partition { |s| s.match?(/^[a-z-]+-by:/i) }

    trailers = trailers.uniq.join.strip
    body = body.join.strip.gsub(/\n{3,}/, "\n\n")

    [subject, body, trailers]
  end

  def signoff!(pr, tap:, args:)
    message = Utils.popen_read "git", "-C", tap.path, "log", "-1", "--pretty=%B"
    subject, body, trailers = separate_commit_message(message)

    # Approving reviewers also sign-off on merge.
    trailers += GitHub.approved_reviews(tap.user, "homebrew-#{tap.repo}", pr).map do |r|
      "Signed-off-by: #{r["name"]} <#{r["email"]}>"
    end.join("\n")

    close_message = "Closes ##{pr}."
    body += "\n\n#{close_message}" unless body.include? close_message
    new_message = [subject, body, trailers].join("\n\n").strip

    if args.dry_run?
      puts "git commit --amend --signoff -m $message"
    else
      safe_system "git", "-C", tap.path, "commit", "--amend", "--signoff", "--allow-empty", "-q", "-m", new_message
    end
  end

  def determine_bump_subject(file, original_commit, path: ".", reason: nil)
    full_path = Pathname.new(path)/file
    formula_name = File.basename(file.chomp(".rb"))

    new_formula = begin
      Formulary::FormulaLoader.new(formula_name, full_path).get_formula(:stable)
    rescue FormulaUnavailableError
      return "#{formula_name}: delete #{reason}"
    end

    old_formula = begin
      old_file = Utils.popen_read "git", "-C", path, "show", "#{original_commit}:#{file}"
      Formulary.from_contents(formula_name, full_path, old_file, :stable)
    rescue FormulaUnavailableError
      return "#{formula_name} #{new_formula.stable.version} (new formula)"
    end

    if old_formula.stable.version != new_formula.stable.version
      "#{formula_name} #{new_formula.stable.version}"
    elsif old_formula.revision != new_formula.revision
      "#{formula_name}: revision #{reason}"
    else
      "#{formula_name}: #{reason || "rebuild"}"
    end
  end

  # Cherry picks a single commit that modifies a single file.
  # Potentially rewords this commit using `determine_bump_subject`.
  def reword_formula_commit(commit, file, args:, path: ".")
    formula_name = File.basename(file.chomp(".rb"))
    odebug "Cherry-picking #{file}: #{commit}"
    Utils::Git.cherry_pick!(path, commit, verbose: args.verbose?, resolve: args.resolve?)

    bump_subject = determine_bump_subject(file, "HEAD^", path: path, reason: args.message).strip
    message = Utils.popen_read("git", "-C", path, "log", "-1", "--pretty=%B")
    subject, body, trailers = separate_commit_message(message)

    if subject != bump_subject && !subject.start_with?("#{formula_name}:")
      safe_system("git", "-C", path, "commit", "--amend", "-q",
                  "-m", bump_subject, "-m", subject, "-m", body, "-m", trailers)
      ohai bump_subject
    else
      ohai subject
    end
  end

  # Cherry picks multiple commits that each modify a single file.
  # Words the commit according to `determine_bump_subject` with the body
  # corresponding to all the original commit messages combined.
  def squash_formula_commits(commits, file, args:, path: ".")
    odebug "Squashing #{file}: #{commits.join " "}"

    # Format commit messages into something similar to `git fmt-merge-message`.
    # * subject 1
    # * subject 2
    #   optional body
    # * subject 3
    messages = []
    trailers = []
    commits.each do |commit|
      original_message = Utils.safe_popen_read("git", "-C", path, "show", "--no-patch", "--pretty=%B", commit)
      subject, body, trailer = separate_commit_message(original_message)
      body = body.lines.map { |line| "  #{line.strip}" }.join("\n")
      messages << "* #{subject}\n#{body}".strip
      trailers << trailer
    end

    # Get the set of authors in this series.
    authors = Utils.safe_popen_read("git", "-C", path, "show",
                                    "--no-patch", "--pretty=%an <%ae>", *commits).lines.map(&:strip).uniq.compact

    # Get the author and date of the first commit of this series, which we use for the squashed commit.
    original_author = authors.shift
    original_date = Utils.safe_popen_read "git", "-C", path, "show", "--no-patch", "--pretty=%ad", commits.first

    # Generate trailers for coauthors and combine them with the existing trailers.
    co_author_trailers = authors.map { |au| "Co-authored-by: #{au}" }
    trailers = [trailers + co_author_trailers].flatten.uniq.compact

    # Apply the patch series but don't commit anything yet.
    Utils::Git.cherry_pick!(path, "--no-commit", *commits, verbose: args.verbose?, resolve: args.resolve?)

    # Determine the bump subject by comparing the original state of the tree to its current state.
    bump_subject = determine_bump_subject(file, "#{commits.first}^", path: path, reason: args.message).strip

    # Commit with the new subject, body, and trailers.
    safe_system("git", "-C", path, "commit", "--quiet",
                "-m", bump_subject, "-m", messages.join("\n"), "-m", trailers.join("\n"),
                "--author", original_author, "--date", original_date, "--", file)
    ohai bump_subject
  end

  def autosquash!(original_commit, path: ".", args: nil)
    # Autosquash assumes we've already modified the current state of the git repository,
    # so just exit early if we're in a dry run.
    return if args.dry_run?

    original_head = Utils.safe_popen_read("git", "-C", path, "rev-parse", "HEAD").strip

    commits = Utils.safe_popen_read("git", "-C", path, "rev-list",
                                    "--reverse", "#{original_commit}..HEAD").lines.map(&:strip)

    # Generate a bidirectional mapping of commits <=> formula files.
    files_to_commits = {}
    commits_to_files = commits.map do |commit|
      files = Utils.safe_popen_read("git", "-C", path, "diff-tree", "--diff-filter=AMD",
                                    "-r", "--name-only", "#{commit}^", commit).lines.map(&:strip)
      files.each do |file|
        files_to_commits[file] ||= []
        files_to_commits[file] << commit
        next if %r{^Formula/.*\.rb$}.match?(file)

        odie <<~EOS
          Autosquash can't squash commits that modify non-formula files.
            File:   #{file}
            Commit: #{commit}
        EOS
      end
      [commit, files]
    end.to_h

    # Reset to state before cherry-picking.
    safe_system "git", "-C", path, "reset", "--hard", original_commit

    # Iterate over every commit in the pull request series, but if we have to squash
    # multiple commits into one, ensure that we skip over commits we've already squashed.
    processed_commits = []
    commits.each do |commit|
      next if processed_commits.include? commit

      files = commits_to_files[commit]
      if files.length == 1 && files_to_commits[files.first].length == 1
        # If there's a 1:1 mapping of commits to files, just cherry pick and (maybe) reword.
        reword_formula_commit(commit, files.first, path: path, args: args)
        processed_commits << commit
      elsif files.length == 1 && files_to_commits[files.first].length > 1
        # If multiple commits modify a single file, squash them down into a single commit.
        file = files.first
        commits = files_to_commits[file]
        squash_formula_commits(commits, file, path: path, args: args)
        processed_commits += commits
      else
        # We can't split commits (yet) so just raise an error.
        odie <<~EOS
          Autosquash can't split commits that modify multiple files.
            Commit: #{commit}
            Files:  #{files.join " "}
        EOS
      end
    end
  rescue
    opoo "Autosquash encountered an error; resetting to original cherry-picked state at #{original_head}"
    system "git", "-C", path, "reset", "--hard", original_head
    system "git", "-C", path, "cherry-pick", "--abort"
    raise
  end

  def cherry_pick_pr!(pr, args:, path: ".")
    if args.dry_run?
      puts <<~EOS
        git fetch --force origin +refs/pull/#{pr}/head
        git merge-base HEAD FETCH_HEAD
        git cherry-pick --ff --allow-empty $merge_base..FETCH_HEAD
      EOS
    else
      safe_system "git", "-C", path, "fetch", "--quiet", "--force", "origin", "+refs/pull/#{pr}/head"
      merge_base = Utils.popen_read("git", "-C", path, "merge-base", "HEAD", "FETCH_HEAD").strip
      commit_count = Utils.popen_read("git", "-C", path, "rev-list", "#{merge_base}..FETCH_HEAD").lines.count

      ohai "Using #{commit_count} commit#{"s" unless commit_count == 1} from ##{pr}"
      Utils::Git.cherry_pick!(path, "--ff", "--allow-empty", "#{merge_base}..FETCH_HEAD",
                              verbose: args.verbose?, resolve: args.resolve?)
    end
  end

  def check_branch(path, ref, args:)
    branch = Utils.popen_read("git", "-C", path, "symbolic-ref", "--short", "HEAD").strip

    return if branch == ref || args.clean? || args.branch_okay?

    opoo "Current branch is #{branch}: do you need to pull inside #{ref}?"
  end

  def formulae_need_bottles?(tap, original_commit, args:)
    return if args.dry_run?

    changed_formulae(tap, original_commit).any? do |f|
      !f.bottle_unneeded? && !f.bottle_disabled?
    end
  end

  def mirror_formulae(tap, original_commit, org:, repo:, args:, publish: true)
    changed_formulae(tap, original_commit).select do |f|
      stable_urls = [f.stable.url] + f.stable.mirrors
      stable_urls.grep(%r{^https://dl.bintray.com/#{org}/#{repo}/}) do |mirror_url|
        if args.dry_run?
          puts "brew mirror #{f.full_name}"
        else
          odebug "Mirroring #{mirror_url}"
          mirror_args = ["mirror", f.full_name]
          mirror_args << "--debug" if args.debug?
          mirror_args << "--verbose" if args.verbose?
          mirror_args << "--bintray-org=#{org}" if org
          mirror_args << "--bintray-repo=#{repo}" if repo
          mirror_args << "--no-publish" unless publish
          system HOMEBREW_BREW_FILE, *mirror_args
        end
      end
    end
  end

  def changed_formulae(tap, original_commit)
    if Homebrew::EnvConfig.disable_load_formula?
      opoo "Can't check if updated bottles are necessary as formula loading is disabled!"
      return
    end

    Utils.popen_read("git", "-C", tap.path, "diff-tree",
                     "-r", "--name-only", "--diff-filter=AM",
                     original_commit, "HEAD", "--", tap.formula_dir)
         .lines
         .map do |line|
      next unless line.end_with? ".rb\n"

      name = "#{tap.name}/#{File.basename(line.chomp, ".rb")}"
      Formula[name]
    end.compact
  end

  def download_artifact(url, dir, pr)
    token, username = GitHub.api_credentials
    case GitHub.api_credentials_type
    when :env_username_password, :keychain_username_password
      curl_args = ["--user", "#{username}:#{token}"]
    when :env_token
      curl_args = ["--header", "Authorization: token #{token}"]
    when :none
      raise Error, "Credentials must be set to access the Artifacts API"
    end

    # Download the artifact as a zip file and unpack it into `dir`. This is
    # preferred over system `curl` and `tar` as this leverages the Homebrew
    # cache to avoid repeated downloads of (possibly large) bottles.
    FileUtils.chdir dir do
      downloader = GitHubArtifactDownloadStrategy.new(url, "artifact", pr, curl_args: curl_args, secrets: [token])
      downloader.fetch
      downloader.stage
    end
  end

  def pr_pull
    args = pr_pull_args.parse

    workflow = args.workflow || "tests.yml"
    artifact = args.artifact || "bottles"
    bintray_org = args.bintray_org || "homebrew"
    mirror_repo = args.bintray_mirror || "mirror"
    tap = Tap.fetch(args.tap || CoreTap.instance.name)

    setup_git_environment!

    args.named.uniq.each do |arg|
      arg = "#{tap.default_remote}/pull/#{arg}" if arg.to_i.positive?
      url_match = arg.match HOMEBREW_PULL_OR_COMMIT_URL_REGEX
      _, user, repo, pr = *url_match
      odie "Not a GitHub pull request: #{arg}" unless pr

      check_branch tap.path, "master", args: args

      ohai "Fetching #{tap} pull request ##{pr}"
      Dir.mktmpdir pr do |dir|
        cd dir do
          original_commit = Utils.popen_read("git", "-C", tap.path, "rev-parse", "HEAD").chomp
          cherry_pick_pr!(pr, path: tap.path, args: args)
          autosquash!(original_commit, path: tap.path, args: args) if args.autosquash?
          signoff!(pr, tap: tap, args: args) unless args.clean?

          unless args.no_upload?
            mirror_formulae(tap, original_commit,
                            org: bintray_org, repo: mirror_repo, publish: !args.no_publish?,
                            args: args)
          end

          unless formulae_need_bottles?(tap, original_commit, args: args)
            ohai "Skipping artifacts for ##{pr} as the formulae don't need bottles"
            next
          end

          url = GitHub.get_artifact_url(user, repo, pr, workflow_id: workflow, artifact_name: artifact)
          download_artifact(url, dir, pr)

          next if args.no_upload?

          upload_args = ["pr-upload"]
          upload_args << "--debug" if args.debug?
          upload_args << "--verbose" if args.verbose?
          upload_args << "--no-publish" if args.no_publish?
          upload_args << "--dry-run" if args.dry_run?
          upload_args << "--keep-old" if args.keep_old?
          upload_args << "--warn-on-upload-failure" if args.warn_on_upload_failure?
          upload_args << "--root-url=#{args.root_url}" if args.root_url
          upload_args << "--bintray-org=#{bintray_org}"
          safe_system HOMEBREW_BREW_FILE, *upload_args
        end
      end
    end
  end
end

class GitHubArtifactDownloadStrategy < AbstractFileDownloadStrategy
  def fetch
    ohai "Downloading #{url}"
    if cached_location.exist?
      puts "Already downloaded: #{cached_location}"
    else
      begin
        curl "--location", "--create-dirs", "--output", temporary_path, url,
             *meta.fetch(:curl_args, []),
             secrets: meta.fetch(:secrets, [])
      rescue ErrorDuringExecution
        raise CurlDownloadStrategyError, url
      end
      ignore_interrupts do
        cached_location.dirname.mkpath
        temporary_path.rename(cached_location)
        symlink_location.dirname.mkpath
      end
    end
    FileUtils.ln_s cached_location.relative_path_from(symlink_location.dirname), symlink_location, force: true
  end

  private

  def resolved_basename
    "artifact.zip"
  end
end
