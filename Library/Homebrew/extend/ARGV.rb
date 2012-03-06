module HomebrewArgvExtension
  def named
    @named ||= reject{|arg| arg[0..0] == '-'}
  end

  def options_only
    select {|arg| arg[0..0] == '-'}
  end

  def formulae
    require 'formula'
    @formulae ||= downcased_unique_named.map{ |name| Formula.factory name }
    return @formulae
  end

  def kegs
    require 'keg'
    require 'formula'
    @kegs ||= downcased_unique_named.collect do |name|
      canonical_name = Formula.canonical_name(name)
      rack = HOMEBREW_CELLAR + if canonical_name.include? "/"
        # canonical_name returns a path if it was a formula installed via a
        # URL. And we only want the name. FIXME that function is insane.
        Pathname.new(canonical_name).stem
      else
        canonical_name
      end
      dirs = rack.children.select{ |pn| pn.directory? } rescue []
      raise NoSuchKegError.new(name) if not rack.directory? or dirs.length == 0

      linked_keg_ref = HOMEBREW_REPOSITORY/"Library/LinkedKegs"/name

      if not linked_keg_ref.symlink?
        raise MultipleVersionsInstalledError.new(name) if dirs.length > 1
        Keg.new(dirs.first)
      else
        Keg.new(linked_keg_ref.realpath)
      end
    end
  end

  # self documenting perhaps?
  def include? arg
    @n=index arg
  end
  def next
    at @n+1 or raise UsageError
  end

  def force?
    flag? '--force'
  end
  def verbose?
    flag? '--verbose' or ENV['HOMEBREW_VERBOSE']
  end
  def debug?
    flag? '--debug' or ENV['HOMEBREW_DEBUG']
  end
  def quieter?
    flag? '--quieter'
  end
  def interactive?
    flag? '--interactive'
  end
  def one?
    flag? '--1'
  end

  def build_head?
    flag? '--HEAD'
  end

  def build_devel?
    include? '--devel'
  end

  def build_universal?
    include? '--universal'
  end

  # Request a 32-bit only build.
  # This is needed for some use-cases though we prefer to build Universal
  # when a 32-bit version is needed.
  def build_32_bit?
    include? '--32-bit'
  end

  def build_bottle?
    MacOS.bottles_supported? and include? '--build-bottle'
  end

  def build_from_source?
    flag? '--build-from-source' or ENV['HOMEBREW_BUILD_FROM_SOURCE'] \
      or not MacOS.bottles_supported? or not options_only.empty?
  end

  def flag? flag
    options_only.each do |arg|
      return true if arg == flag
      next if arg[1..1] == '-'
      return true if arg.include? flag[2..2]
    end
    return false
  end

  def usage
    require 'cmd/help'
    Homebrew.help_s
  end

  def filter_for_dependencies
    # Clears some flags that affect installation, yields to a block, then
    # restores to original state.
    old_args = clone

    flags_to_clear = %w[
      --debug -d
      --devel
      --fresh
      --interactive -i
      --HEAD
    ]
    flags_to_clear.concat %w[--verbose -v] if quieter?
    flags_to_clear.each {|flag| delete flag}

    yield

    replace old_args
  end

  private

  def downcased_unique_named
    # Only lowercase names, not paths or URLs
    @downcased_unique_named ||= named.map do |arg|
      arg.include?("/") ? arg : arg.downcase
    end.uniq
  end
end
