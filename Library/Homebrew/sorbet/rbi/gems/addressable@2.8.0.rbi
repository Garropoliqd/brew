# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `addressable` gem.
# Please instead update this file by running `bin/tapioca sync`.

# typed: true

module Addressable; end

module Addressable::IDNA
  class << self
    def to_ascii(input); end
    def to_unicode(input); end
    def unicode_normalize_kc(input); end

    private

    def lookup_unicode_combining_class(codepoint); end
    def lookup_unicode_compatibility(codepoint); end
    def lookup_unicode_composition(unpacked); end
    def lookup_unicode_lowercase(codepoint); end
    def punycode_adapt(delta, numpoints, firsttime); end
    def punycode_basic?(codepoint); end
    def punycode_decode(punycode); end
    def punycode_decode_digit(codepoint); end
    def punycode_delimiter?(codepoint); end
    def punycode_encode(unicode); end
    def punycode_encode_digit(d); end
    def ucs4_to_utf8(char, buffer); end
    def unicode_compose(unpacked); end
    def unicode_compose_pair(ch_one, ch_two); end
    def unicode_decompose(unpacked); end
    def unicode_decompose_hangul(codepoint); end
    def unicode_downcase(input); end
    def unicode_sort_canonical(unpacked); end
  end
end

Addressable::IDNA::ACE_MAX_LENGTH = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::ACE_PREFIX = T.let(T.unsafe(nil), String)
Addressable::IDNA::COMPOSITION_TABLE = T.let(T.unsafe(nil), Hash)
Addressable::IDNA::HANGUL_LBASE = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::HANGUL_LCOUNT = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::HANGUL_NCOUNT = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::HANGUL_SBASE = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::HANGUL_SCOUNT = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::HANGUL_TBASE = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::HANGUL_TCOUNT = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::HANGUL_VBASE = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::HANGUL_VCOUNT = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::PUNYCODE_BASE = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::PUNYCODE_DAMP = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::PUNYCODE_DELIMITER = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::PUNYCODE_INITIAL_BIAS = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::PUNYCODE_INITIAL_N = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::PUNYCODE_MAXINT = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::PUNYCODE_PRINT_ASCII = T.let(T.unsafe(nil), String)
Addressable::IDNA::PUNYCODE_SKEW = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::PUNYCODE_TMAX = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::PUNYCODE_TMIN = T.let(T.unsafe(nil), Integer)
class Addressable::IDNA::PunycodeBadInput < ::StandardError; end
class Addressable::IDNA::PunycodeBigOutput < ::StandardError; end
class Addressable::IDNA::PunycodeOverflow < ::StandardError; end
Addressable::IDNA::UNICODE_DATA = T.let(T.unsafe(nil), Hash)
Addressable::IDNA::UNICODE_DATA_CANONICAL = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::UNICODE_DATA_COMBINING_CLASS = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::UNICODE_DATA_COMPATIBILITY = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::UNICODE_DATA_EXCLUSION = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::UNICODE_DATA_LOWERCASE = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::UNICODE_DATA_TITLECASE = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::UNICODE_DATA_UPPERCASE = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::UNICODE_MAX_LENGTH = T.let(T.unsafe(nil), Integer)
Addressable::IDNA::UNICODE_TABLE = T.let(T.unsafe(nil), String)
Addressable::IDNA::UTF8_REGEX = T.let(T.unsafe(nil), Regexp)
Addressable::IDNA::UTF8_REGEX_MULTIBYTE = T.let(T.unsafe(nil), Regexp)

class Addressable::Template
  def initialize(pattern); end

  def ==(template); end
  def eql?(template); end
  def expand(mapping, processor = T.unsafe(nil), normalize_values = T.unsafe(nil)); end
  def extract(uri, processor = T.unsafe(nil)); end
  def freeze; end
  def inspect; end
  def keys; end
  def match(uri, processor = T.unsafe(nil)); end
  def named_captures; end
  def names; end
  def partial_expand(mapping, processor = T.unsafe(nil), normalize_values = T.unsafe(nil)); end
  def pattern; end
  def source; end
  def to_regexp; end
  def variable_defaults; end
  def variables; end

  private

  def join_values(operator, return_value); end
  def normalize_keys(mapping); end
  def normalize_value(value); end
  def ordered_variable_defaults; end
  def parse_new_template_pattern(pattern, processor = T.unsafe(nil)); end
  def parse_template_pattern(pattern, processor = T.unsafe(nil)); end
  def transform_capture(mapping, capture, processor = T.unsafe(nil), normalize_values = T.unsafe(nil)); end
  def transform_partial_capture(mapping, capture, processor = T.unsafe(nil), normalize_values = T.unsafe(nil)); end
end

Addressable::Template::EXPRESSION = T.let(T.unsafe(nil), Regexp)
class Addressable::Template::InvalidTemplateOperatorError < ::StandardError; end
class Addressable::Template::InvalidTemplateValueError < ::StandardError; end
Addressable::Template::JOINERS = T.let(T.unsafe(nil), Hash)
Addressable::Template::LEADERS = T.let(T.unsafe(nil), Hash)

class Addressable::Template::MatchData
  def initialize(uri, template, mapping); end

  def [](key, len = T.unsafe(nil)); end
  def captures; end
  def inspect; end
  def keys; end
  def mapping; end
  def names; end
  def post_match; end
  def pre_match; end
  def string; end
  def template; end
  def to_a; end
  def to_s; end
  def uri; end
  def values; end
  def values_at(*indexes); end
  def variables; end
end

Addressable::Template::RESERVED = T.let(T.unsafe(nil), String)
class Addressable::Template::TemplateOperatorAbortedError < ::StandardError; end
Addressable::Template::UNRESERVED = T.let(T.unsafe(nil), String)
Addressable::Template::VARIABLE_LIST = T.let(T.unsafe(nil), Regexp)
Addressable::Template::VARNAME = T.let(T.unsafe(nil), Regexp)
Addressable::Template::VARSPEC = T.let(T.unsafe(nil), Regexp)

class Addressable::URI
  def initialize(options = T.unsafe(nil)); end

  def +(uri); end
  def ==(uri); end
  def ===(uri); end
  def absolute?; end
  def authority; end
  def authority=(new_authority); end
  def basename; end
  def default_port; end
  def defer_validation; end
  def display_uri; end
  def domain; end
  def dup; end
  def empty?; end
  def eql?(uri); end
  def extname; end
  def fragment; end
  def fragment=(new_fragment); end
  def freeze; end
  def hash; end
  def host; end
  def host=(new_host); end
  def hostname; end
  def hostname=(new_hostname); end
  def inferred_port; end
  def inspect; end
  def ip_based?; end
  def join(uri); end
  def join!(uri); end
  def merge(hash); end
  def merge!(uri); end
  def normalize; end
  def normalize!; end
  def normalized_authority; end
  def normalized_fragment; end
  def normalized_host; end
  def normalized_password; end
  def normalized_path; end
  def normalized_port; end
  def normalized_query(*flags); end
  def normalized_scheme; end
  def normalized_site; end
  def normalized_user; end
  def normalized_userinfo; end
  def omit(*components); end
  def omit!(*components); end
  def origin; end
  def origin=(new_origin); end
  def password; end
  def password=(new_password); end
  def path; end
  def path=(new_path); end
  def port; end
  def port=(new_port); end
  def query; end
  def query=(new_query); end
  def query_values(return_type = T.unsafe(nil)); end
  def query_values=(new_query_values); end
  def relative?; end
  def request_uri; end
  def request_uri=(new_request_uri); end
  def route_from(uri); end
  def route_to(uri); end
  def scheme; end
  def scheme=(new_scheme); end
  def site; end
  def site=(new_site); end
  def tld; end
  def tld=(new_tld); end
  def to_hash; end
  def to_s; end
  def to_str; end
  def user; end
  def user=(new_user); end
  def userinfo; end
  def userinfo=(new_userinfo); end

  protected

  def remove_composite_values; end
  def replace_self(uri); end
  def split_path(path); end
  def validate; end

  class << self
    def convert_path(path); end
    def encode(uri, return_type = T.unsafe(nil)); end
    def encode_component(component, character_class = T.unsafe(nil), upcase_encoded = T.unsafe(nil)); end
    def escape(uri, return_type = T.unsafe(nil)); end
    def escape_component(component, character_class = T.unsafe(nil), upcase_encoded = T.unsafe(nil)); end
    def form_encode(form_values, sort = T.unsafe(nil)); end
    def form_unencode(encoded_value); end
    def heuristic_parse(uri, hints = T.unsafe(nil)); end
    def ip_based_schemes; end
    def join(*uris); end
    def normalize_component(component, character_class = T.unsafe(nil), leave_encoded = T.unsafe(nil)); end
    def normalize_path(path); end
    def normalized_encode(uri, return_type = T.unsafe(nil)); end
    def parse(uri); end
    def port_mapping; end
    def unencode(uri, return_type = T.unsafe(nil), leave_encoded = T.unsafe(nil)); end
    def unencode_component(uri, return_type = T.unsafe(nil), leave_encoded = T.unsafe(nil)); end
    def unescape(uri, return_type = T.unsafe(nil), leave_encoded = T.unsafe(nil)); end
    def unescape_component(uri, return_type = T.unsafe(nil), leave_encoded = T.unsafe(nil)); end
  end
end

module Addressable::URI::CharacterClasses; end
Addressable::URI::CharacterClasses::ALPHA = T.let(T.unsafe(nil), String)
Addressable::URI::CharacterClasses::AUTHORITY = T.let(T.unsafe(nil), String)
Addressable::URI::CharacterClasses::DIGIT = T.let(T.unsafe(nil), String)
Addressable::URI::CharacterClasses::FRAGMENT = T.let(T.unsafe(nil), String)
Addressable::URI::CharacterClasses::GEN_DELIMS = T.let(T.unsafe(nil), String)
Addressable::URI::CharacterClasses::HOST = T.let(T.unsafe(nil), String)
Addressable::URI::CharacterClasses::PATH = T.let(T.unsafe(nil), String)
Addressable::URI::CharacterClasses::PCHAR = T.let(T.unsafe(nil), String)
Addressable::URI::CharacterClasses::QUERY = T.let(T.unsafe(nil), String)
Addressable::URI::CharacterClasses::RESERVED = T.let(T.unsafe(nil), String)
Addressable::URI::CharacterClasses::SCHEME = T.let(T.unsafe(nil), String)
Addressable::URI::CharacterClasses::SUB_DELIMS = T.let(T.unsafe(nil), String)
Addressable::URI::CharacterClasses::UNRESERVED = T.let(T.unsafe(nil), String)
Addressable::URI::EMPTY_STR = T.let(T.unsafe(nil), String)
class Addressable::URI::InvalidURIError < ::StandardError; end
Addressable::URI::NORMPATH = T.let(T.unsafe(nil), Regexp)
module Addressable::URI::NormalizeCharacterClasses; end
Addressable::URI::NormalizeCharacterClasses::FRAGMENT = T.let(T.unsafe(nil), Regexp)
Addressable::URI::NormalizeCharacterClasses::HOST = T.let(T.unsafe(nil), Regexp)
Addressable::URI::NormalizeCharacterClasses::PCHAR = T.let(T.unsafe(nil), Regexp)
Addressable::URI::NormalizeCharacterClasses::QUERY = T.let(T.unsafe(nil), Regexp)
Addressable::URI::NormalizeCharacterClasses::SCHEME = T.let(T.unsafe(nil), Regexp)
Addressable::URI::NormalizeCharacterClasses::UNRESERVED = T.let(T.unsafe(nil), Regexp)
Addressable::URI::PARENT = T.let(T.unsafe(nil), String)
Addressable::URI::PORT_MAPPING = T.let(T.unsafe(nil), Hash)
Addressable::URI::RULE_2A = T.let(T.unsafe(nil), Regexp)
Addressable::URI::RULE_2B_2C = T.let(T.unsafe(nil), Regexp)
Addressable::URI::RULE_2D = T.let(T.unsafe(nil), Regexp)
Addressable::URI::RULE_PREFIXED_PARENT = T.let(T.unsafe(nil), Regexp)
Addressable::URI::SELF_REF = T.let(T.unsafe(nil), String)
Addressable::URI::SEQUENCE_ENCODING_TABLE = T.let(T.unsafe(nil), Hash)
Addressable::URI::SEQUENCE_UPCASED_PERCENT_ENCODING_TABLE = T.let(T.unsafe(nil), Hash)
Addressable::URI::SLASH = T.let(T.unsafe(nil), String)
Addressable::URI::URIREGEX = T.let(T.unsafe(nil), Regexp)
module Addressable::VERSION; end
Addressable::VERSION::MAJOR = T.let(T.unsafe(nil), Integer)
Addressable::VERSION::MINOR = T.let(T.unsafe(nil), Integer)
Addressable::VERSION::STRING = T.let(T.unsafe(nil), String)
Addressable::VERSION::TINY = T.let(T.unsafe(nil), Integer)
