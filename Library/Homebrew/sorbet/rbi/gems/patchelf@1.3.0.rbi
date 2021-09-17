# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `patchelf` gem.
# Please instead update this file by running `bin/tapioca gem patchelf`.

# typed: true

module PatchELF; end

module PatchELF::Helper
  private

  def aligndown(val, align = T.unsafe(nil)); end
  def alignup(val, align = T.unsafe(nil)); end
  def color_enabled?; end
  def colorize(str, type); end

  class << self
    def aligndown(val, align = T.unsafe(nil)); end
    def alignup(val, align = T.unsafe(nil)); end
    def color_enabled?; end
    def colorize(str, type); end
  end
end

PatchELF::Helper::COLOR_CODE = T.let(T.unsafe(nil), Hash)
PatchELF::Helper::PAGE_SIZE = T.let(T.unsafe(nil), Integer)

module PatchELF::Logger
  private

  def debug(msg); end
  def error(msg); end
  def info(msg); end
  def level=(msg); end
  def warn(msg); end

  class << self
    def debug(msg); end
    def error(msg); end
    def info(msg); end
    def level=(msg); end
    def warn(msg); end
  end
end

class PatchELF::MM
  def initialize(elf); end

  def dispatch!; end
  def extend_size; end
  def extended?; end
  def extended_offset(off); end
  def malloc(size, &block); end
  def threshold; end

  private

  def abnormal_elf(msg); end
  def extend_backward(seg, size = T.unsafe(nil)); end
  def extend_forward(seg, size = T.unsafe(nil)); end
  def fgap_method; end
  def find_gap(check_sz: T.unsafe(nil)); end
  def invoke_callbacks(seg, start); end
  def load_segments; end
  def mgap_method; end
  def new_load_method; end
  def shift_attributes; end
  def writable?(seg); end
end

class PatchELF::MissingSegmentError < ::PatchELF::PatchError; end
class PatchELF::MissingTagError < ::PatchELF::PatchError; end
class PatchELF::PatchError < ::ELFTools::ELFError; end

class PatchELF::Patcher
  def initialize(filename, on_error: T.unsafe(nil), logging: T.unsafe(nil)); end

  def add_needed(need); end
  def elf; end
  def interpreter; end
  def interpreter=(interp); end
  def needed; end
  def needed=(needs); end
  def remove_needed(need); end
  def replace_needed(src, tar); end
  def rpath; end
  def rpath=(rpath); end
  def runpath; end
  def runpath=(runpath); end
  def save(out_file = T.unsafe(nil), patchelf_compatible: T.unsafe(nil)); end
  def soname; end
  def soname=(name); end
  def use_rpath!; end

  private

  def dirty?; end
  def dynamic_or_log; end
  def interpreter_; end
  def log_or_raise(msg, exception = T.unsafe(nil)); end
  def needed_; end
  def runpath_(rpath_sym = T.unsafe(nil)); end
  def soname_; end
  def tag_name_or_log(type, log_msg); end
end

class PatchELF::Saver
  def initialize(in_file, out_file, set); end

  def in_file; end
  def out_file; end
  def save!; end

  private

  def dynamic; end
  def expand_dynamic!; end
  def inline_patch(off, str); end
  def lazy_dyn(sym); end
  def malloc_strtab!; end
  def patch_dynamic; end
  def patch_interpreter; end
  def patch_needed; end
  def patch_out(out_file); end
  def patch_runpath(sym = T.unsafe(nil)); end
  def patch_soname; end
  def reg_str_table(str, &block); end
  def section_header(name); end
  def strtab_string; end
end

PatchELF::Saver::IGNORE = T.let(T.unsafe(nil), Integer)
PatchELF::VERSION = T.let(T.unsafe(nil), String)
