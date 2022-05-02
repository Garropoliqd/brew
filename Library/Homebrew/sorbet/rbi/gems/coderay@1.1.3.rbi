# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `coderay` gem.
# Please instead update this file by running `bin/tapioca gem coderay`.

module CodeRay
  class << self
    def coderay_path(*path); end
    def encode(code, lang, format, options = T.unsafe(nil)); end
    def encode_file(filename, format, options = T.unsafe(nil)); end
    def encode_tokens(tokens, format, options = T.unsafe(nil)); end
    def encoder(format, options = T.unsafe(nil)); end
    def get_scanner_options(options); end
    def highlight(code, lang, options = T.unsafe(nil), format = T.unsafe(nil)); end
    def highlight_file(filename, options = T.unsafe(nil), format = T.unsafe(nil)); end
    def scan(code, lang, options = T.unsafe(nil), &block); end
    def scan_file(filename, lang = T.unsafe(nil), options = T.unsafe(nil), &block); end
    def scanner(lang, options = T.unsafe(nil), &block); end
  end
end

CodeRay::CODERAY_PATH = T.let(T.unsafe(nil), String)

class CodeRay::Duo
  def initialize(lang = T.unsafe(nil), format = T.unsafe(nil), options = T.unsafe(nil)); end

  def call(code, options = T.unsafe(nil)); end
  def encode(code, options = T.unsafe(nil)); end
  def encoder; end
  def format; end
  def format=(_arg0); end
  def highlight(code, options = T.unsafe(nil)); end
  def lang; end
  def lang=(_arg0); end
  def options; end
  def options=(_arg0); end
  def scanner; end

  class << self
    def [](*_arg0); end
  end
end

module CodeRay::Encoders
  extend ::CodeRay::PluginHost
end

class CodeRay::Encoders::CommentFilter < ::CodeRay::Encoders::TokenKindFilter; end
CodeRay::Encoders::CommentFilter::DEFAULT_OPTIONS = T.let(T.unsafe(nil), Hash)

class CodeRay::Encoders::Count < ::CodeRay::Encoders::Encoder
  def begin_group(kind); end
  def begin_line(kind); end
  def end_group(kind); end
  def end_line(kind); end
  def text_token(text, kind); end

  protected

  def finish(options); end
  def setup(options); end
end

class CodeRay::Encoders::Debug < ::CodeRay::Encoders::Encoder
  def begin_group(kind); end
  def begin_line(kind); end
  def end_group(kind); end
  def end_line(kind); end
  def text_token(text, kind); end
end

CodeRay::Encoders::Debug::FILE_EXTENSION = T.let(T.unsafe(nil), String)

class CodeRay::Encoders::DebugLint < ::CodeRay::Encoders::Debug
  def begin_group(kind); end
  def begin_line(kind); end
  def end_group(kind); end
  def end_line(kind); end
  def text_token(text, kind); end

  protected

  def finish(options); end
  def setup(options); end
end

class CodeRay::Encoders::Div < ::CodeRay::Encoders::HTML; end
CodeRay::Encoders::Div::DEFAULT_OPTIONS = T.let(T.unsafe(nil), Hash)
CodeRay::Encoders::Div::FILE_EXTENSION = T.let(T.unsafe(nil), String)

class CodeRay::Encoders::Encoder
  extend ::CodeRay::Plugin

  def initialize(options = T.unsafe(nil)); end

  def <<(token); end
  def begin_group(kind); end
  def begin_line(kind); end
  def encode(code, lang, options = T.unsafe(nil)); end
  def encode_tokens(tokens, options = T.unsafe(nil)); end
  def end_group(kind); end
  def end_line(kind); end
  def file_extension; end
  def highlight(code, lang, options = T.unsafe(nil)); end
  def options; end
  def options=(_arg0); end
  def scanner; end
  def scanner=(_arg0); end
  def text_token(text, kind); end
  def token(content, kind); end
  def tokens(tokens, options = T.unsafe(nil)); end

  protected

  def compile(tokens, options = T.unsafe(nil)); end
  def finish(options); end
  def get_output(options); end
  def output(data); end
  def setup(options); end

  class << self
    def const_missing(sym); end
    def file_extension; end
  end
end

CodeRay::Encoders::Encoder::DEFAULT_OPTIONS = T.let(T.unsafe(nil), Hash)
CodeRay::Encoders::Encoder::PLUGIN_HOST = CodeRay::Encoders

class CodeRay::Encoders::Filter < ::CodeRay::Encoders::Encoder
  def begin_group(kind); end
  def begin_line(kind); end
  def end_group(kind); end
  def end_line(kind); end
  def text_token(text, kind); end

  protected

  def finish(options); end
  def setup(options); end
end

class CodeRay::Encoders::HTML < ::CodeRay::Encoders::Encoder
  def begin_group(kind); end
  def begin_line(kind); end
  def css; end
  def end_group(kind); end
  def end_line(kind); end
  def text_token(text, kind); end

  protected

  def break_lines(text, style); end
  def check_group_nesting(name, kind); end
  def check_options!(options); end
  def close_span; end
  def css_class_for_kinds(kinds); end
  def finish(options); end
  def make_span_for_kinds(method, hint); end
  def setup(options); end
  def style_for_kinds(kinds); end

  class << self
    def make_html_escape_hash; end
    def token_path_to_hint(hint, kinds); end
  end
end

class CodeRay::Encoders::HTML::CSS
  def initialize(style = T.unsafe(nil)); end

  def get_style_for_css_classes(css_classes); end
  def stylesheet; end

  private

  def parse(stylesheet); end

  class << self
    def load_stylesheet(style = T.unsafe(nil)); end
  end
end

CodeRay::Encoders::HTML::CSS::CSS_CLASS_PATTERN = T.let(T.unsafe(nil), Regexp)
CodeRay::Encoders::HTML::DEFAULT_OPTIONS = T.let(T.unsafe(nil), Hash)
CodeRay::Encoders::HTML::FILE_EXTENSION = T.let(T.unsafe(nil), String)
CodeRay::Encoders::HTML::HTML_ESCAPE = T.let(T.unsafe(nil), Hash)
CodeRay::Encoders::HTML::HTML_ESCAPE_PATTERN = T.let(T.unsafe(nil), Regexp)

module CodeRay::Encoders::HTML::Numbering
  class << self
    def number!(output, mode = T.unsafe(nil), options = T.unsafe(nil)); end
  end
end

module CodeRay::Encoders::HTML::Output
  def apply_title!(title); end
  def css; end
  def css=(_arg0); end
  def stylesheet(in_tag = T.unsafe(nil)); end
  def wrap!(element, *args); end
  def wrap_in!(template); end
  def wrapped_in; end
  def wrapped_in=(_arg0); end
  def wrapped_in?(element); end

  class << self
    def extended(o); end
    def make_stylesheet(css, in_tag = T.unsafe(nil)); end
    def page_template_for_css(css); end
  end
end

CodeRay::Encoders::HTML::Output::DIV = T.let(T.unsafe(nil), CodeRay::Encoders::HTML::Output::Template)
CodeRay::Encoders::HTML::Output::PAGE = T.let(T.unsafe(nil), CodeRay::Encoders::HTML::Output::Template)
CodeRay::Encoders::HTML::Output::SPAN = T.let(T.unsafe(nil), CodeRay::Encoders::HTML::Output::Template)
CodeRay::Encoders::HTML::Output::TABLE = T.let(T.unsafe(nil), CodeRay::Encoders::HTML::Output::Template)

class CodeRay::Encoders::HTML::Output::Template < ::String
  def apply(target, replacement); end

  class << self
    def wrap!(str, template, target); end
  end
end

CodeRay::Encoders::HTML::TOKEN_KIND_TO_INFO = T.let(T.unsafe(nil), Hash)
CodeRay::Encoders::HTML::TRANSPARENT_TOKEN_KINDS = T.let(T.unsafe(nil), Set)

class CodeRay::Encoders::JSON < ::CodeRay::Encoders::Encoder
  def begin_group(kind); end
  def begin_line(kind); end
  def end_group(kind); end
  def end_line(kind); end
  def text_token(text, kind); end

  protected

  def append(data); end
  def finish(options); end
  def setup(options); end
end

CodeRay::Encoders::JSON::FILE_EXTENSION = T.let(T.unsafe(nil), String)

class CodeRay::Encoders::LinesOfCode < ::CodeRay::Encoders::TokenKindFilter
  protected

  def finish(options); end
  def setup(options); end
end

CodeRay::Encoders::LinesOfCode::NON_EMPTY_LINE = T.let(T.unsafe(nil), Regexp)

class CodeRay::Encoders::Lint < ::CodeRay::Encoders::Debug
  def begin_group(kind); end
  def begin_line(kind); end
  def end_group(kind); end
  def end_line(kind); end
  def text_token(text, kind); end

  protected

  def finish(options); end
  def setup(options); end
end

class CodeRay::Encoders::Lint::EmptyToken < ::CodeRay::Encoders::Lint::InvalidTokenStream; end
class CodeRay::Encoders::Lint::IncorrectTokenGroupNesting < ::CodeRay::Encoders::Lint::InvalidTokenStream; end
class CodeRay::Encoders::Lint::InvalidTokenStream < ::StandardError; end
class CodeRay::Encoders::Lint::UnknownTokenKind < ::CodeRay::Encoders::Lint::InvalidTokenStream; end

class CodeRay::Encoders::Null < ::CodeRay::Encoders::Encoder
  def text_token(text, kind); end
end

class CodeRay::Encoders::Page < ::CodeRay::Encoders::HTML; end
CodeRay::Encoders::Page::DEFAULT_OPTIONS = T.let(T.unsafe(nil), Hash)
CodeRay::Encoders::Page::FILE_EXTENSION = T.let(T.unsafe(nil), String)
class CodeRay::Encoders::Span < ::CodeRay::Encoders::HTML; end
CodeRay::Encoders::Span::DEFAULT_OPTIONS = T.let(T.unsafe(nil), Hash)
CodeRay::Encoders::Span::FILE_EXTENSION = T.let(T.unsafe(nil), String)

class CodeRay::Encoders::Statistic < ::CodeRay::Encoders::Encoder
  def begin_group(kind); end
  def begin_line(kind); end
  def block_token(action, kind); end
  def end_group(kind); end
  def end_line(kind); end
  def real_token_count; end
  def text_token(text, kind); end
  def type_stats; end

  protected

  def finish(options); end
  def setup(options); end
end

CodeRay::Encoders::Statistic::STATS = T.let(T.unsafe(nil), String)
CodeRay::Encoders::Statistic::TOKEN_TYPES_ROW = T.let(T.unsafe(nil), String)

class CodeRay::Encoders::Statistic::TypeStats < ::Struct
  def count; end
  def count=(_); end
  def size; end
  def size=(_); end

  class << self
    def [](*_arg0); end
    def inspect; end
    def members; end
    def new(*_arg0); end
  end
end

class CodeRay::Encoders::Terminal < ::CodeRay::Encoders::Encoder
  def begin_group(kind); end
  def begin_line(kind); end
  def end_group(kind); end
  def end_line(kind); end
  def text_token(text, kind); end

  protected

  def setup(options); end

  private

  def open_token(kind); end
end

CodeRay::Encoders::Terminal::TOKEN_COLORS = T.let(T.unsafe(nil), Hash)

class CodeRay::Encoders::Text < ::CodeRay::Encoders::Encoder
  def text_token(text, kind); end

  protected

  def setup(options); end
end

CodeRay::Encoders::Text::DEFAULT_OPTIONS = T.let(T.unsafe(nil), Hash)
CodeRay::Encoders::Text::FILE_EXTENSION = T.let(T.unsafe(nil), String)

class CodeRay::Encoders::TokenKindFilter < ::CodeRay::Encoders::Filter
  def begin_group(kind); end
  def begin_line(kind); end
  def end_group(kind); end
  def end_line(kind); end
  def text_token(text, kind); end

  protected

  def include_group?(kind); end
  def include_text_token?(text, kind); end
  def setup(options); end
end

CodeRay::Encoders::TokenKindFilter::DEFAULT_OPTIONS = T.let(T.unsafe(nil), Hash)

class CodeRay::Encoders::XML < ::CodeRay::Encoders::Encoder
  def begin_group(kind); end
  def end_group(kind); end
  def text_token(text, kind); end

  protected

  def finish(options); end
  def setup(options); end
end

CodeRay::Encoders::XML::DEFAULT_OPTIONS = T.let(T.unsafe(nil), Hash)
CodeRay::Encoders::XML::FILE_EXTENSION = T.let(T.unsafe(nil), String)

class CodeRay::Encoders::YAML < ::CodeRay::Encoders::Encoder
  def begin_group(kind); end
  def begin_line(kind); end
  def end_group(kind); end
  def end_line(kind); end
  def text_token(text, kind); end

  protected

  def finish(options); end
  def setup(options); end
end

CodeRay::Encoders::YAML::FILE_EXTENSION = T.let(T.unsafe(nil), String)

module CodeRay::FileType
  class << self
    def [](filename, read_shebang = T.unsafe(nil)); end
    def fetch(filename, default = T.unsafe(nil), read_shebang = T.unsafe(nil)); end

    protected

    def type_from_shebang(filename); end
  end
end

CodeRay::FileType::TypeFromExt = T.let(T.unsafe(nil), Hash)
CodeRay::FileType::TypeFromName = T.let(T.unsafe(nil), Hash)
CodeRay::FileType::TypeFromShebang = T.let(T.unsafe(nil), Regexp)
class CodeRay::FileType::UnknownFileType < ::Exception; end

module CodeRay::Plugin
  def aliases; end
  def plugin_host(host = T.unsafe(nil)); end
  def plugin_id; end
  def register_for(id); end
  def title(title = T.unsafe(nil)); end
end

module CodeRay::PluginHost
  def [](id, *args, &blk); end
  def all_plugins; end
  def const_missing(const); end
  def default(id = T.unsafe(nil)); end
  def list; end
  def load(id, *args, &blk); end
  def load_all; end
  def load_plugin_map; end
  def map(hash); end
  def plugin_hash; end
  def plugin_path(*args); end
  def register(plugin, id); end

  protected

  def make_plugin_hash; end
  def path_to(plugin_id); end
  def validate_id(id); end

  class << self
    def extended(mod); end
  end
end

class CodeRay::PluginHost::HostNotFound < ::LoadError; end
CodeRay::PluginHost::PLUGIN_HOSTS = T.let(T.unsafe(nil), Array)
CodeRay::PluginHost::PLUGIN_HOSTS_BY_ID = T.let(T.unsafe(nil), Hash)
class CodeRay::PluginHost::PluginNotFound < ::LoadError; end

module CodeRay::Scanners
  extend ::CodeRay::PluginHost
end

class CodeRay::Scanners::C < ::CodeRay::Scanners::Scanner
  protected

  def scan_tokens(encoder, options); end
end

CodeRay::Scanners::C::DIRECTIVES = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::C::ESCAPE = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::C::IDENT_KIND = T.let(T.unsafe(nil), CodeRay::WordList)
CodeRay::Scanners::C::KEYWORDS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::C::PREDEFINED_CONSTANTS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::C::PREDEFINED_TYPES = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::C::UNICODE_ESCAPE = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CPlusPlus = CodeRay::Scanners::Text

class CodeRay::Scanners::CSS < ::CodeRay::Scanners::Scanner
  protected

  def scan_tokens(encoder, options); end
  def setup; end
end

CodeRay::Scanners::CSS::KINDS_NOT_LOC = T.let(T.unsafe(nil), Array)
module CodeRay::Scanners::CSS::RE; end
CodeRay::Scanners::CSS::RE::AtKeyword = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::AttributeSelector = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::Class = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::Dimension = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::Escape = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::Function = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::Hex = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::HexColor = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::Id = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::Ident = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::NMChar = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::NMStart = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::Name = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::Num = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::Percentage = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::PseudoClass = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::String = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::String1 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::String2 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::Unicode = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::CSS::RE::Unit = T.let(T.unsafe(nil), Regexp)

class CodeRay::Scanners::Clojure < ::CodeRay::Scanners::Scanner
  protected

  def scan_tokens(encoder, options); end
end

CodeRay::Scanners::Clojure::BASIC_IDENTIFIER = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::COMPLEX10 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::COMPLEX16 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::COMPLEX2 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::COMPLEX8 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::CORE_FORMS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Clojure::DECIMAL = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::DIGIT = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::DIGIT10 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::DIGIT16 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::DIGIT2 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::DIGIT8 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::EXACTNESS = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::EXP = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::EXP_MARK = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::IDENTIFIER = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::IDENT_KIND = T.let(T.unsafe(nil), CodeRay::WordList)
CodeRay::Scanners::Clojure::IMAG10 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::IMAG16 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::IMAG2 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::IMAG8 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::KEYWORD_NEXT_TOKEN_KIND = T.let(T.unsafe(nil), CodeRay::WordList)
CodeRay::Scanners::Clojure::NUM = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::NUM10 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::NUM16 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::NUM2 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::NUM8 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::PREDEFINED_CONSTANTS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Clojure::PREFIX10 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::PREFIX16 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::PREFIX2 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::PREFIX8 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::RADIX10 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::RADIX16 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::RADIX2 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::RADIX8 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::REAL10 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::REAL16 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::REAL2 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::REAL8 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::SIGN = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::SPECIAL_FORMS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Clojure::SUFFIX = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::SYMBOL = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::UINT10 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::UINT16 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::UINT2 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::UINT8 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::UREAL10 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::UREAL16 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::UREAL2 = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Clojure::UREAL8 = T.let(T.unsafe(nil), Regexp)

class CodeRay::Scanners::Debug < ::CodeRay::Scanners::Scanner
  protected

  def scan_tokens(encoder, options); end
  def setup; end
end

class CodeRay::Scanners::Delphi < ::CodeRay::Scanners::Scanner
  protected

  def scan_tokens(encoder, options); end
end

CodeRay::Scanners::Delphi::DIRECTIVES = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Delphi::IDENT_KIND = T.let(T.unsafe(nil), CodeRay::WordList::CaseIgnoring)
CodeRay::Scanners::Delphi::KEYWORDS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Delphi::NAME_FOLLOWS = T.let(T.unsafe(nil), CodeRay::WordList::CaseIgnoring)

class CodeRay::Scanners::Diff < ::CodeRay::Scanners::Scanner
  protected

  def scan_tokens(encoder, options); end

  private

  def diff(a, b); end
end

CodeRay::Scanners::Diff::DEFAULT_OPTIONS = T.let(T.unsafe(nil), Hash)

class CodeRay::Scanners::ERB < ::CodeRay::Scanners::Scanner
  protected

  def reset_instance; end
  def scan_tokens(encoder, options); end
  def setup; end
end

CodeRay::Scanners::ERB::ERB_RUBY_BLOCK = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::ERB::KINDS_NOT_LOC = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::ERB::START_OF_ERB = T.let(T.unsafe(nil), Regexp)

class CodeRay::Scanners::Go < ::CodeRay::Scanners::Scanner
  protected

  def scan_tokens(encoder, options); end
end

CodeRay::Scanners::Go::ESCAPE = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Go::IDENT_KIND = T.let(T.unsafe(nil), CodeRay::WordList)
CodeRay::Scanners::Go::KEYWORDS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Go::PREDEFINED_CONSTANTS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Go::PREDEFINED_FUNCTIONS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Go::PREDEFINED_TYPES = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Go::UNICODE_ESCAPE = T.let(T.unsafe(nil), Regexp)

class CodeRay::Scanners::Groovy < ::CodeRay::Scanners::Java
  protected

  def scan_tokens(encoder, options); end
  def setup; end
end

CodeRay::Scanners::Groovy::ESCAPE = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Groovy::GROOVY_KEYWORDS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Groovy::GROOVY_MAGIC_VARIABLES = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Groovy::IDENT_KIND = T.let(T.unsafe(nil), CodeRay::WordList)
CodeRay::Scanners::Groovy::KEYWORDS_EXPECTING_VALUE = T.let(T.unsafe(nil), CodeRay::WordList)
CodeRay::Scanners::Groovy::REGEXP_ESCAPE = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Groovy::STRING_CONTENT_PATTERN = T.let(T.unsafe(nil), Hash)
CodeRay::Scanners::Groovy::UNICODE_ESCAPE = T.let(T.unsafe(nil), Regexp)

class CodeRay::Scanners::HAML < ::CodeRay::Scanners::Scanner
  protected

  def scan_tokens(encoder, options); end
  def setup; end
end

CodeRay::Scanners::HAML::KINDS_NOT_LOC = T.let(T.unsafe(nil), Array)

class CodeRay::Scanners::HTML < ::CodeRay::Scanners::Scanner
  def reset; end

  protected

  def scan_css(encoder, code, state = T.unsafe(nil)); end
  def scan_java_script(encoder, code); end
  def scan_tokens(encoder, options); end
  def setup; end
end

CodeRay::Scanners::HTML::ATTR_NAME = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::HTML::ENTITY = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::HTML::EVENT_ATTRIBUTES = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::HTML::HEX = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::HTML::IN_ATTRIBUTE = T.let(T.unsafe(nil), CodeRay::WordList::CaseIgnoring)
CodeRay::Scanners::HTML::KINDS_NOT_LOC = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::HTML::PLAIN_STRING_CONTENT = T.let(T.unsafe(nil), Hash)
CodeRay::Scanners::HTML::TAG_END = T.let(T.unsafe(nil), Regexp)

class CodeRay::Scanners::JSON < ::CodeRay::Scanners::Scanner
  protected

  def scan_tokens(encoder, options); end
  def setup; end
end

CodeRay::Scanners::JSON::ESCAPE = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::JSON::KEY = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::JSON::KINDS_NOT_LOC = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::JSON::UNICODE_ESCAPE = T.let(T.unsafe(nil), Regexp)

class CodeRay::Scanners::Java < ::CodeRay::Scanners::Scanner
  protected

  def scan_tokens(encoder, options); end
end

module CodeRay::Scanners::Java::BuiltinTypes; end
CodeRay::Scanners::Java::BuiltinTypes::List = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Java::CONSTANTS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Java::DIRECTIVES = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Java::ESCAPE = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Java::IDENT = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Java::IDENT_KIND = T.let(T.unsafe(nil), CodeRay::WordList)
CodeRay::Scanners::Java::KEYWORDS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Java::MAGIC_VARIABLES = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Java::RESERVED = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Java::STRING_CONTENT_PATTERN = T.let(T.unsafe(nil), Hash)
CodeRay::Scanners::Java::TYPES = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Java::UNICODE_ESCAPE = T.let(T.unsafe(nil), Regexp)

class CodeRay::Scanners::JavaScript < ::CodeRay::Scanners::Scanner
  protected

  def reset_instance; end
  def scan_tokens(encoder, options); end
  def setup; end
  def xml_scanner; end
end

CodeRay::Scanners::JavaScript::ESCAPE = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::JavaScript::IDENT_KIND = T.let(T.unsafe(nil), CodeRay::WordList)
CodeRay::Scanners::JavaScript::KEYWORDS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::JavaScript::KEYWORDS_EXPECTING_VALUE = T.let(T.unsafe(nil), CodeRay::WordList)
CodeRay::Scanners::JavaScript::KEY_CHECK_PATTERN = T.let(T.unsafe(nil), Hash)
CodeRay::Scanners::JavaScript::MAGIC_VARIABLES = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::JavaScript::PREDEFINED_CONSTANTS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::JavaScript::REGEXP_ESCAPE = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::JavaScript::RESERVED_WORDS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::JavaScript::STRING_CONTENT_PATTERN = T.let(T.unsafe(nil), Hash)
CodeRay::Scanners::JavaScript::UNICODE_ESCAPE = T.let(T.unsafe(nil), Regexp)

class CodeRay::Scanners::Lua < ::CodeRay::Scanners::Scanner
  protected

  def scan_tokens(encoder, options); end
  def setup; end
end

CodeRay::Scanners::Lua::IDENT_KIND = T.let(T.unsafe(nil), CodeRay::WordList)
CodeRay::Scanners::Lua::KEYWORDS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Lua::PREDEFINED_CONSTANTS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Lua::PREDEFINED_EXPRESSIONS = T.let(T.unsafe(nil), Array)

class CodeRay::Scanners::PHP < ::CodeRay::Scanners::Scanner
  protected

  def reset_instance; end
  def scan_tokens(encoder, options); end
  def setup; end
end

CodeRay::Scanners::PHP::KINDS_NOT_LOC = T.let(T.unsafe(nil), Array)
module CodeRay::Scanners::PHP::RE; end
CodeRay::Scanners::PHP::RE::HTML_INDICATOR = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::PHP::RE::IDENTIFIER = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::PHP::RE::OPERATOR = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::PHP::RE::PHP_END = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::PHP::RE::PHP_START = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::PHP::RE::VARIABLE = T.let(T.unsafe(nil), Regexp)
module CodeRay::Scanners::PHP::Words; end
CodeRay::Scanners::PHP::Words::BUILTIN_FUNCTIONS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::PHP::Words::CLASSES = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::PHP::Words::CONSTANTS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::PHP::Words::EXCEPTIONS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::PHP::Words::IDENT_KIND = T.let(T.unsafe(nil), CodeRay::WordList::CaseIgnoring)
CodeRay::Scanners::PHP::Words::KEYWORDS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::PHP::Words::LANGUAGE_CONSTRUCTS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::PHP::Words::PREDEFINED = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::PHP::Words::TYPES = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::PHP::Words::VARIABLE_KIND = T.let(T.unsafe(nil), CodeRay::WordList)

class CodeRay::Scanners::Python < ::CodeRay::Scanners::Scanner
  protected

  def scan_tokens(encoder, options); end
end

CodeRay::Scanners::Python::DEF_NEW_STATE = T.let(T.unsafe(nil), CodeRay::WordList)
CodeRay::Scanners::Python::DESCRIPTOR = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Python::DOCSTRING_COMING = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Python::ESCAPE = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Python::IDENT_KIND = T.let(T.unsafe(nil), CodeRay::WordList)
CodeRay::Scanners::Python::KEYWORDS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Python::NAME = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Python::OLD_KEYWORDS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Python::OPERATOR = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Python::PREDEFINED_EXCEPTIONS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Python::PREDEFINED_METHODS_AND_TYPES = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Python::PREDEFINED_VARIABLES_AND_CONSTANTS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Python::STRING_CONTENT_REGEXP = T.let(T.unsafe(nil), Hash)
CodeRay::Scanners::Python::STRING_DELIMITER_REGEXP = T.let(T.unsafe(nil), Hash)
CodeRay::Scanners::Python::UNICODE_ESCAPE = T.let(T.unsafe(nil), Regexp)

class CodeRay::Scanners::Raydebug < ::CodeRay::Scanners::Scanner
  protected

  def scan_tokens(encoder, options); end
  def setup; end
end

class CodeRay::Scanners::Ruby < ::CodeRay::Scanners::Scanner
  def interpreted_string_state; end

  protected

  def scan_tokens(encoder, options); end
  def setup; end
end

module CodeRay::Scanners::Ruby::Patterns; end
CodeRay::Scanners::Ruby::Patterns::BINARY = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::CHARACTER = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::CLASS_VARIABLE = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::CONTROL_META_ESCAPE = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::DATA = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::DECIMAL = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::ESCAPE = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::EXPONENT = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::FANCY_STRING_INTERPRETED = T.let(T.unsafe(nil), Hash)
CodeRay::Scanners::Ruby::Patterns::FANCY_STRING_KIND = T.let(T.unsafe(nil), Hash)
CodeRay::Scanners::Ruby::Patterns::FANCY_STRING_START = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::FLOAT_OR_INT = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::FLOAT_SUFFIX = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::GLOBAL_VARIABLE = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::HEREDOC_OPEN = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::HEXADECIMAL = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::IDENT = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::IDENT_KIND = T.let(T.unsafe(nil), CodeRay::WordList)
CodeRay::Scanners::Ruby::Patterns::INSTANCE_VARIABLE = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::KEYWORDS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Ruby::Patterns::KEYWORDS_EXPECTING_VALUE = T.let(T.unsafe(nil), CodeRay::WordList)
CodeRay::Scanners::Ruby::Patterns::KEYWORD_NEW_STATE = T.let(T.unsafe(nil), CodeRay::WordList)
CodeRay::Scanners::Ruby::Patterns::METHOD_AFTER_DOT = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::METHOD_NAME = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::METHOD_NAME_EX = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::METHOD_NAME_OPERATOR = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::METHOD_NAME_OR_SYMBOL = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::METHOD_SUFFIX = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::NUMERIC = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::OBJECT_VARIABLE = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::OCTAL = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::PREDEFINED_CONSTANTS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Ruby::Patterns::PREFIX_VARIABLE = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::QUOTE_TO_TYPE = T.let(T.unsafe(nil), Hash)
CodeRay::Scanners::Ruby::Patterns::REGEXP_MODIFIERS = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::RUBYDOC = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::RUBYDOC_OR_DATA = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::SIMPLE_ESCAPE = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::SYMBOL = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::VALUE_FOLLOWS = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::Ruby::Patterns::VARIABLE = T.let(T.unsafe(nil), Regexp)

class CodeRay::Scanners::Ruby::StringState < ::Struct
  def initialize(kind, interpreted, delim, heredoc = T.unsafe(nil)); end

  def heredoc_pattern(delim, interpreted, indented); end

  class << self
    def simple_key_pattern(delim); end
  end
end

CodeRay::Scanners::Ruby::StringState::CLOSING_PAREN = T.let(T.unsafe(nil), Hash)
CodeRay::Scanners::Ruby::StringState::STRING_PATTERN = T.let(T.unsafe(nil), Hash)

class CodeRay::Scanners::SQL < ::CodeRay::Scanners::Scanner
  def scan_tokens(encoder, options); end
end

CodeRay::Scanners::SQL::COMMANDS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::SQL::DIRECTIVES = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::SQL::ESCAPE = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::SQL::IDENT_KIND = T.let(T.unsafe(nil), CodeRay::WordList::CaseIgnoring)
CodeRay::Scanners::SQL::KEYWORDS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::SQL::OBJECTS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::SQL::PREDEFINED_CONSTANTS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::SQL::PREDEFINED_FUNCTIONS = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::SQL::PREDEFINED_TYPES = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::SQL::STRING_CONTENT_PATTERN = T.let(T.unsafe(nil), Hash)
CodeRay::Scanners::SQL::STRING_PREFIXES = T.let(T.unsafe(nil), Regexp)
CodeRay::Scanners::SQL::UNICODE_ESCAPE = T.let(T.unsafe(nil), Regexp)

class CodeRay::Scanners::Sass < ::CodeRay::Scanners::CSS
  protected

  def scan_tokens(encoder, options); end
  def setup; end
end

class CodeRay::Scanners::Scanner < ::StringScanner
  include ::Enumerable
  extend ::CodeRay::Plugin

  def initialize(code = T.unsafe(nil), options = T.unsafe(nil)); end

  def binary_string; end
  def column(pos = T.unsafe(nil)); end
  def each(&block); end
  def file_extension; end
  def lang; end
  def line(pos = T.unsafe(nil)); end
  def reset; end
  def state; end
  def state=(_arg0); end
  def string=(code); end
  def tokenize(source = T.unsafe(nil), options = T.unsafe(nil)); end
  def tokens; end

  protected

  def raise_inspect(message, tokens, state = T.unsafe(nil), ambit = T.unsafe(nil), backtrace = T.unsafe(nil)); end
  def raise_inspect_arguments(message, tokens, state, ambit); end
  def reset_instance; end
  def scan_rest; end
  def scan_tokens(tokens, options); end
  def scanner_state_info(state); end
  def set_string_from_source(source); end
  def set_tokens_from_options(options); end
  def setup; end
  def tokens_last(tokens, n); end
  def tokens_size(tokens); end

  class << self
    def encoding(name = T.unsafe(nil)); end
    def file_extension(extension = T.unsafe(nil)); end
    def lang; end
    def normalize(code); end

    protected

    def encode_with_encoding(code, target_encoding); end
    def guess_encoding(s); end
    def to_unix(code); end
  end
end

CodeRay::Scanners::Scanner::DEFAULT_OPTIONS = T.let(T.unsafe(nil), Hash)
CodeRay::Scanners::Scanner::KINDS_NOT_LOC = T.let(T.unsafe(nil), Array)
CodeRay::Scanners::Scanner::PLUGIN_HOST = CodeRay::Scanners
CodeRay::Scanners::Scanner::SCANNER_STATE_INFO = T.let(T.unsafe(nil), String)
CodeRay::Scanners::Scanner::SCAN_ERROR_MESSAGE = T.let(T.unsafe(nil), String)
class CodeRay::Scanners::Scanner::ScanError < ::StandardError; end

class CodeRay::Scanners::Taskpaper < ::CodeRay::Scanners::Scanner
  protected

  def scan_tokens(encoder, options); end
end

class CodeRay::Scanners::Text < ::CodeRay::Scanners::Scanner
  protected

  def scan_tokens(encoder, options); end
end

CodeRay::Scanners::Text::KINDS_NOT_LOC = T.let(T.unsafe(nil), Array)
class CodeRay::Scanners::XML < ::CodeRay::Scanners::HTML; end

class CodeRay::Scanners::YAML < ::CodeRay::Scanners::Scanner
  protected

  def scan_tokens(encoder, options); end
end

CodeRay::Scanners::YAML::KINDS_NOT_LOC = T.let(T.unsafe(nil), Symbol)

module CodeRay::Styles
  extend ::CodeRay::PluginHost
end

class CodeRay::Styles::Alpha < ::CodeRay::Styles::Style; end
CodeRay::Styles::Alpha::CSS_MAIN_STYLES = T.let(T.unsafe(nil), String)
CodeRay::Styles::Alpha::TOKEN_COLORS = T.let(T.unsafe(nil), String)

class CodeRay::Styles::Style
  extend ::CodeRay::Plugin
end

CodeRay::Styles::Style::DEFAULT_OPTIONS = T.let(T.unsafe(nil), Hash)
CodeRay::Styles::Style::PLUGIN_HOST = CodeRay::Styles
CodeRay::TokenKinds = T.let(T.unsafe(nil), Hash)

class CodeRay::Tokens < ::Array
  def begin_group(kind); end
  def begin_line(kind); end
  def count; end
  def encode(encoder, options = T.unsafe(nil)); end
  def end_group(kind); end
  def end_line(kind); end
  def method_missing(meth, options = T.unsafe(nil)); end
  def scanner; end
  def scanner=(_arg0); end
  def split_into_parts(*sizes); end
  def text_token(*_arg0); end
  def to_s; end
  def tokens(*_arg0); end
end

class CodeRay::TokensProxy
  def initialize(input, lang, options = T.unsafe(nil), block = T.unsafe(nil)); end

  def block; end
  def block=(_arg0); end
  def each(*args, &blk); end
  def encode(encoder, options = T.unsafe(nil)); end
  def input; end
  def input=(_arg0); end
  def lang; end
  def lang=(_arg0); end
  def method_missing(method, *args, &blk); end
  def options; end
  def options=(_arg0); end
  def scanner; end
  def tokens; end
end

CodeRay::VERSION = T.let(T.unsafe(nil), String)

class CodeRay::WordList < ::Hash
  def initialize(default = T.unsafe(nil)); end

  def add(words, value = T.unsafe(nil)); end
end

class CodeRay::WordList::CaseIgnoring < ::CodeRay::WordList
  def [](key); end
  def []=(key, value); end
end
