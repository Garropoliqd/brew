# frozen_string_literal: true

require "cli/args"
require "optparse"
require "set"
require "formula"

COMMAND_DESC_WIDTH = 80
OPTION_DESC_WIDTH = 43

module Homebrew
  module CLI
    class Parser
      attr_reader :processed_options, :hide_from_man_page

      def self.from_cmd_path(cmd_path)
        cmd_args_method_name = Commands.args_method_name(cmd_path)

        begin
          Homebrew.send(cmd_args_method_name) if require?(cmd_path)
        rescue NoMethodError => e
          raise if e.name != cmd_args_method_name

          nil
        end
      end

      def self.global_options
        [
          ["-q", "--quiet", "Suppress any warnings."],
          ["-v", "--verbose", "Make some output more verbose."],
          ["-d", "--debug", "Display any debugging information."],
        ]
      end

      def initialize(argv = ARGV.dup.freeze, &block)
        @parser = OptionParser.new

        @argv = argv
        @args = Homebrew::CLI::Args.new(@argv)

        @constraints = []
        @conflicts = []
        @switch_sources = {}
        @processed_options = []
        @max_named_args = nil
        @min_named_args = nil
        @min_named_type = nil
        @hide_from_man_page = false

        self.class.global_options.each do |short, long, desc|
          switch short, long, description: desc
        end

        instance_eval(&block) if block_given?

        post_initialize
      end

      def post_initialize
        # Disable default handling of `--version` switch.
        @parser.base.long.delete("version")

        # Disable default handling of `--help` switch.
        @parser.on_tail("-h", "--help", "Show this message.") do
          raise OptionParser::InvalidOption
        end
      end

      def switch(*names, description: nil, env: nil, required_for: nil, depends_on: nil)
        global_switch = names.first.is_a?(Symbol)
        return if global_switch

        description = option_to_description(*names) if description.nil?
        process_option(*names, description)
        @parser.on(*names, *wrap_option_desc(description)) do
          enable_switch(*names, from: :args)
        end

        names.each do |name|
          set_constraints(name, required_for: required_for, depends_on: depends_on)
        end

        enable_switch(*names, from: :env) if env?(env)
      end
      alias switch_option switch

      def env?(env)
        return false if env.blank?

        Homebrew::EnvConfig.send("#{env}?")
      rescue NoMethodError
        false
      end

      def usage_banner(text)
        @parser.banner = Formatter.wrap("#{text}\n", COMMAND_DESC_WIDTH)
      end

      def usage_banner_text
        @parser.banner
      end

      def comma_array(name, description: nil)
        name = name.chomp "="
        description = option_to_description(name) if description.nil?
        process_option(name, description)
        @parser.on(name, OptionParser::REQUIRED_ARGUMENT, Array, *wrap_option_desc(description)) do |list|
          @args[option_to_name(name)] = list
        end
      end

      def flag(*names, description: nil, required_for: nil, depends_on: nil)
        required = if names.any? { |name| name.end_with? "=" }
          OptionParser::REQUIRED_ARGUMENT
        else
          OptionParser::OPTIONAL_ARGUMENT
        end
        names.map! { |name| name.chomp "=" }
        description = option_to_description(*names) if description.nil?
        process_option(*names, description)
        @parser.on(*names, *wrap_option_desc(description), required) do |option_value|
          names.each do |name|
            @args[option_to_name(name)] = option_value
          end
        end

        names.each do |name|
          set_constraints(name, required_for: required_for, depends_on: depends_on)
        end
      end

      def conflicts(*options)
        @conflicts << options.map { |option| option_to_name(option) }
      end

      def option_to_name(option)
        option.sub(/\A--?/, "")
              .tr("-", "_")
              .delete("=")
      end

      def name_to_option(name)
        if name.length == 1
          "-#{name}"
        else
          "--#{name.tr("_", "-")}"
        end
      end

      def option_to_description(*names)
        names.map { |name| name.to_s.sub(/\A--?/, "").tr("-", " ") }.max
      end

      def summary
        @parser.to_s
      end

      def parse(argv = @argv, ignore_invalid_options: false)
        raise "Arguments were already parsed!" if @args_parsed

        i = 0
        remaining = []

        argv, non_options = split_double_dash(argv)

        while i < argv.count
          begin
            begin
              arg = argv[i]

              remaining << arg unless @parser.parse([arg]).empty?
            rescue OptionParser::MissingArgument
              raise if i + 1 >= argv.count

              args = argv[i..(i + 1)]
              @parser.parse(args)
              i += 1
            end
          rescue OptionParser::InvalidOption
            if ignore_invalid_options
              remaining << arg
            else
              $stderr.puts generate_help_text
              raise
            end
          end

          i += 1
        end

        named_args = if ignore_invalid_options
          []
        else
          remaining + non_options
        end

        check_constraint_violations
        check_named_args(named_args)
        @args.freeze_named_args!(named_args)
        @args.freeze_processed_options!(@processed_options)

        @args_parsed = true
        @args
      end

      def generate_help_text
        @parser.to_s
               .sub(/^/, "#{Tty.bold}Usage: brew#{Tty.reset} ")
               .gsub(/`(.*?)`/m, "#{Tty.bold}\\1#{Tty.reset}")
               .gsub(%r{<([^\s]+?://[^\s]+?)>}) { |url| Formatter.url(url) }
               .gsub(/<(.*?)>/m, "#{Tty.underline}\\1#{Tty.reset}")
               .gsub(/\*(.*?)\*/m, "#{Tty.underline}\\1#{Tty.reset}")
      end

      def formula_options
        formulae(@argv).each do |f|
          next if f.options.empty?

          f.options.each do |o|
            name = o.flag
            description = "`#{f.name}`: #{o.description}"
            if name.end_with? "="
              flag   name, description: description
            else
              switch name, description: description
            end
          end
        end
      rescue FormulaUnavailableError
        []
      end

      def max_named(count)
        raise TypeError, "Unsupported type #{count.class.name} for max_named" unless count.is_a?(Integer)

        @max_named_args = count
      end

      def min_named(count_or_type)
        case count_or_type
        when Integer
          @min_named_args = count_or_type
          @min_named_type = nil
        when Symbol
          @min_named_args = 1
          @min_named_type = count_or_type
        else
          raise TypeError, "Unsupported type #{count_or_type.class.name} for min_named"
        end
      end

      def named(count_or_type)
        case count_or_type
        when Integer
          @max_named_args = @min_named_args = count_or_type
          @min_named_type = nil
        when Symbol
          @max_named_args = @min_named_args = 1
          @min_named_type = count_or_type
        else
          raise TypeError, "Unsupported type #{count_or_type.class.name} for named"
        end
      end

      def hide_from_man_page!
        @hide_from_man_page = true
      end

      private

      def enable_switch(*names, from:)
        names.each do |name|
          @switch_sources[option_to_name(name)] = from
          @args["#{option_to_name(name)}?"] = true
        end
      end

      def disable_switch(*names)
        names.each do |name|
          @args.delete_field("#{option_to_name(name)}?")
        end
      end

      def option_passed?(name)
        @args[name.to_sym] || @args["#{name}?".to_sym]
      end

      def wrap_option_desc(desc)
        Formatter.wrap(desc, OPTION_DESC_WIDTH).split("\n")
      end

      def set_constraints(name, depends_on:, required_for:)
        secondary = option_to_name(name)
        unless required_for.nil?
          primary = option_to_name(required_for)
          @constraints << [primary, secondary, :mandatory]
        end

        return if depends_on.nil?

        primary = option_to_name(depends_on)
        @constraints << [primary, secondary, :optional]
      end

      def check_constraints
        @constraints.each do |primary, secondary, constraint_type|
          primary_passed = option_passed?(primary)
          secondary_passed = option_passed?(secondary)
          if :mandatory.equal?(constraint_type) && primary_passed && !secondary_passed
            raise OptionConstraintError.new(primary, secondary)
          end
          raise OptionConstraintError.new(primary, secondary, missing: true) if secondary_passed && !primary_passed
        end
      end

      def check_conflicts
        @conflicts.each do |mutually_exclusive_options_group|
          violations = mutually_exclusive_options_group.select do |option|
            option_passed? option
          end

          next if violations.count < 2

          env_var_options = violations.select do |option|
            @switch_sources[option_to_name(option)] == :env
          end

          select_cli_arg = violations.count - env_var_options.count == 1
          raise OptionConflictError, violations.map(&method(:name_to_option)) unless select_cli_arg

          env_var_options.each(&method(:disable_switch))
        end
      end

      def check_invalid_constraints
        @conflicts.each do |mutually_exclusive_options_group|
          @constraints.each do |p, s|
            next unless Set[p, s].subset?(Set[*mutually_exclusive_options_group])

            raise InvalidConstraintError.new(p, s)
          end
        end
      end

      def check_constraint_violations
        check_invalid_constraints
        check_conflicts
        check_constraints
      end

      def check_named_args(args)
        min_exception = case @min_named_type
        when :cask
          Cask::CaskUnspecifiedError.new
        when :formula
          FormulaUnspecifiedError.new
        when :keg
          KegUnspecifiedError.new
        else
          MinNamedArgumentsError.new(@min_named_args)
        end
        raise min_exception if @min_named_args && args.size < @min_named_args
        raise MaxNamedArgumentsError, @max_named_args if @max_named_args && args.size > @max_named_args
      end

      def process_option(*args)
        option, = @parser.make_switch(args)
        @processed_options << [option.short.first, option.long.first, option.arg, option.desc.first]
      end

      def split_double_dash(argv)
        if sep = argv.index("--")
          [argv.take(sep), argv.drop(sep + 1)]
        else
          [argv, []]
        end
      end

      def formulae(argv)
        argv, named_argv = split_double_dash(argv)

        named_args = argv.reject { |arg| arg.start_with?("-") } + named_argv
        spec = if argv.include?("--HEAD")
          :head
        elsif argv.include?("--devel")
          :devel
        else
          :stable
        end

        # Only lowercase names, not paths, bottle filenames or URLs
        named_args.map do |arg|
          next if arg.match?(HOMEBREW_CASK_TAP_CASK_REGEX)

          Formulary.factory(arg, spec, flags: @args.flags_only)
        end.compact.uniq(&:name)
      end
    end

    class OptionConstraintError < RuntimeError
      def initialize(arg1, arg2, missing: false)
        message = if !missing
          "`#{arg1}` and `#{arg2}` should be passed together."
        else
          "`#{arg2}` cannot be passed without `#{arg1}`."
        end
        super message
      end
    end

    class OptionConflictError < RuntimeError
      def initialize(args)
        args_list = args.map(&Formatter.public_method(:option))
                        .join(" and ")
        super "Options #{args_list} are mutually exclusive."
      end
    end

    class InvalidConstraintError < RuntimeError
      def initialize(arg1, arg2)
        super "`#{arg1}` and `#{arg2}` cannot be mutually exclusive and mutually dependent simultaneously."
      end
    end

    class MaxNamedArgumentsError < UsageError
      def initialize(maximum)
        message = case maximum
        when 0
          "this command does not take named arguments"
        when 1
          "this command does not take multiple named arguments"
        else
          "this command does not take more than #{maximum} named arguments"
        end
        super message
      end
    end

    class MinNamedArgumentsError < UsageError
      def initialize(minimum)
        message = case minimum
        when 1
          "this command requires a named argument"
        when 2
          "this command requires multiple named arguments"
        else
          "this command requires at least #{minimum} named arguments"
        end
        super message
      end
    end
  end
end
