# typed: strict
# frozen_string_literal: true

module UnpackStrategy
  # Strategy for unpacking ZIP archives.
  class Zip
    extend T::Sig

    include UnpackStrategy

    using Magic

    sig { returns(T::Array[String]) }
    def self.extensions
      [".zip"]
    end

    sig { params(path: Pathname).returns(T::Boolean) }
    def self.can_extract?(path)
      path.magic_number.match?(/\APK(\003\004|\005\006)/n)
    end

    private

    sig {
      override.params(unpack_dir: Pathname, basename: Pathname, verbose: T::Boolean)
              .returns(SystemCommand::Result)
    }
    def extract_to_dir(unpack_dir, basename:, verbose:)
      unzip = begin
        Formula["unzip"]
      rescue FormulaUnavailableError
        nil
      end

      with_env(TZ: "UTC") do
        quiet_flags = verbose ? [] : ["-qq"]
        result = system_command! "unzip",
                                 args:         [*quiet_flags, "-o", path, "-d", unpack_dir],
                                 env:          { "PATH" => PATH.new(unzip&.opt_bin, ENV["PATH"]) },
                                 verbose:      verbose,
                                 print_stderr: false

        FileUtils.rm_rf unpack_dir/"__MACOSX"

        result
      end
    end
  end
end

require "extend/os/mac/unpack_strategy/zip" if OS.mac?
