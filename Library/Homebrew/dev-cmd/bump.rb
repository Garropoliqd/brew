# frozen_string_literal: true

require "cli/parser"

module Homebrew
  module_function

  def bump_args
    Homebrew::CLI::Parser.new do
      usage_banner <<~EOS
        `bump` [<options>]

        Display out-of-date brew formulae and the latest version available.
        Also displays whether a pull request has been opened with the URL.
      EOS
      flag "--formula=",
           description: "Return results for package by name."
      flag "--limit=",
           description: "Limit number of package results returned."
      switch :verbose
      switch :debug
    end
  end

  def bump
    bump_args.parse

    requested_formula = Homebrew.args.formula
    requested_formula&.downcase!

    raise FormulaUnavailableError, requested_formula if requested_formula && !validate_formula(requested_formula)

    repology_data = if requested_formula
      Repology.single_package_query(requested_formula)
    else
      Repology.parse_api_response
    end

    validated_formulae = Repology.validate_and_format_packages(repology_data)
    display(validated_formulae)
  end

  def validate_formula(formula_name)
    Formula[formula_name]
  rescue
    nil
  end

  def up_to_date?(package)
    package[:current_formula_version] == package[:repology_latest_version] &&
      package[:current_formula_version] == package[:livecheck_latest_version]
  end

  def display(formulae)
    puts
    formulae.each do |formula, package_details|
      title = (up_to_date?(package_details) ? formula + " is up to date!" : formula).to_s
      ohai title
      puts "Current formula version:  #{package_details[:current_formula_version]}"
      puts "Latest Repology version:  #{package_details[:repology_latest_version]}"
      puts "Latest livecheck version: #{package_details[:livecheck_latest_version] || "Not found"}"
      puts "Open pull requests: #{package_details[:open_pull_requests] || "None"}"
    end
  end
end
