# frozen_string_literal: true

require "formula"
require "os/linux/glibc"

module SystemConfig
  SYSTEM_RUBY_PATH = "/usr/bin/ruby"
  class << self
    def host_glibc_version
      version = OS::Linux::Glibc.system_version
      return "N/A" if version.null?

      version
    end

    def host_gcc_version
      gcc = Pathname.new "/usr/bin/gcc"
      return "N/A" unless gcc.executable?

      `#{gcc} --version 2>/dev/null`[/ (\d+\.\d+\.\d+)/, 1]
    end

    def formula_linked_version(formula)
      return "N/A" unless CoreTap.instance.installed?

      Formulary.factory(formula).linked_version || "N/A"
    rescue FormulaUnavailableError
      "N/A"
    end

    def system_ruby_version
      out, _, status = system_command(SYSTEM_RUBY_PATH, args: ["-e", "puts RUBY_VERSION"], print_stderr: false)
      return "N/A" unless status.success?

      out
    end

    def dump_verbose_config(out = $stdout)
      dump_generic_verbose_config(out)
      out.puts "Kernel: #{`uname -mors`.chomp}"
      out.puts "OS: #{OS::Linux.os_version}"
      out.puts "Host glibc: #{host_glibc_version}"
      out.puts "/usr/bin/gcc: #{host_gcc_version}"
      out.puts "/usr/bin/ruby: #{system_ruby_version}" if RUBY_PATH != SYSTEM_RUBY_PATH
      ["glibc", "gcc", "xorg"].each do |f|
        out.puts "#{f}: #{formula_linked_version f}"
      end
    end
  end
end
