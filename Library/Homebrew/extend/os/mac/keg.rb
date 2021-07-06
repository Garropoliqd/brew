# typed: true
# frozen_string_literal: true

class Keg
  GENERIC_KEG_LINK_DIRECTORIES = (remove_const :KEG_LINK_DIRECTORIES).freeze
  KEG_LINK_DIRECTORIES = (GENERIC_KEG_LINK_DIRECTORIES + ["Frameworks"]).freeze
  GENERIC_MUST_EXIST_SUBDIRECTORIES = (remove_const :MUST_EXIST_SUBDIRECTORIES).freeze
  MUST_EXIST_SUBDIRECTORIES = (
    GENERIC_MUST_EXIST_SUBDIRECTORIES +
    [HOMEBREW_PREFIX/"Frameworks"]
  ).sort.uniq.freeze
  GENERIC_MUST_EXIST_DIRECTORIES = (remove_const :MUST_EXIST_DIRECTORIES).freeze
  MUST_EXIST_DIRECTORIES = (
    GENERIC_MUST_EXIST_DIRECTORIES +
    [HOMEBREW_PREFIX/"Frameworks"]
  ).sort.uniq.freeze
  GENERIC_MUST_BE_WRITABLE_DIRECTORIES = (remove_const :MUST_BE_WRITABLE_DIRECTORIES).freeze
  MUST_BE_WRITABLE_DIRECTORIES = (
    GENERIC_MUST_BE_WRITABLE_DIRECTORIES +
    [HOMEBREW_PREFIX/"Frameworks"]
  ).sort.uniq.freeze

  undef binary_executable_or_library_files

  def binary_executable_or_library_files
    mach_o_files
  end
end
