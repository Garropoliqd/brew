# typed: false
# frozen_string_literal: true

require "macho"

# {Pathname} extension for dealing with Mach-O files.
#
# @api private
module MachOShim
  extend Forwardable

  delegate [:dylib_id, :rpaths] => :macho

  def macho
    @macho ||= MachO.open(to_s)
  end
  private :macho

  def mach_data
    @mach_data ||= begin
      machos = []
      mach_data = []

      if MachO::Utils.fat_magic?(macho.magic)
        machos = macho.machos
      else
        machos << macho
      end

      machos.each do |m|
        arch = case m.cputype
        when :x86_64, :i386, :ppc64 then m.cputype
        when :ppc then :ppc7400
        else :dunno
        end

        type = case m.filetype
        when :dylib, :bundle then m.filetype
        when :execute then :executable
        else :dunno
        end

        mach_data << { arch: arch, type: type }
      end

      mach_data
    rescue MachO::NotAMachOError
      # Silently ignore errors that indicate the file is not a Mach-O binary ...
      []
    rescue
      # ... but complain about other (parse) errors for further investigation.
      onoe "Failed to read Mach-O binary: #{self}"
      raise if Homebrew::EnvConfig.developer?

      []
    end
  end
  private :mach_data

  def dynamically_linked_libraries(except: :none)
    lcs = macho.dylib_load_commands.reject { |lc| lc.type == except }

    lcs.map(&:name).map(&:to_s).uniq
  end

  def archs
    mach_data.map { |m| m.fetch :arch }
  end

  def arch
    case archs.length
    when 0 then :dunno
    when 1 then archs.first
    else :universal
    end
  end

  def universal?
    arch == :universal
  end

  def i386?
    arch == :i386
  end

  def x86_64?
    arch == :x86_64
  end

  def ppc7400?
    arch == :ppc7400
  end

  def ppc64?
    arch == :ppc64
  end

  def dylib?
    mach_data.any? { |m| m.fetch(:type) == :dylib }
  end

  def mach_o_executable?
    mach_data.any? { |m| m.fetch(:type) == :executable }
  end

  alias binary_executable? mach_o_executable?

  def mach_o_bundle?
    mach_data.any? { |m| m.fetch(:type) == :bundle }
  end
end
