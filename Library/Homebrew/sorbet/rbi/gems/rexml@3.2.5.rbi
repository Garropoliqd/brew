# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `rexml` gem.
# Please instead update this file by running `bin/tapioca gem rexml`.

# typed: true

class REXML::AttlistDecl < ::REXML::Child
  include ::Enumerable

  def initialize(source); end

  def [](key); end
  def each(&block); end
  def element_name; end
  def include?(key); end
  def node_type; end
  def write(out, indent = T.unsafe(nil)); end
end

class REXML::Attribute
  include ::REXML::Node
  include ::REXML::XMLTokens
  include ::REXML::Namespace

  def initialize(first, second = T.unsafe(nil), parent = T.unsafe(nil)); end

  def ==(other); end
  def clone; end
  def doctype; end
  def element; end
  def element=(element); end
  def hash; end
  def inspect; end
  def namespace(arg = T.unsafe(nil)); end
  def node_type; end
  def normalized=(_arg0); end
  def prefix; end
  def remove; end
  def to_s; end
  def to_string; end
  def value; end
  def write(output, indent = T.unsafe(nil)); end
  def xpath; end
end

class REXML::Attributes < ::Hash
  def initialize(element); end

  def <<(attribute); end
  def [](name); end
  def []=(name, value); end
  def add(attribute); end
  def delete(attribute); end
  def delete_all(name); end
  def each; end
  def each_attribute; end
  def get_attribute(name); end
  def get_attribute_ns(namespace, name); end
  def length; end
  def namespaces; end
  def prefixes; end
  def size; end
  def to_a; end
end

class REXML::CData < ::REXML::Text
  def initialize(first, whitespace = T.unsafe(nil), parent = T.unsafe(nil)); end

  def clone; end
  def to_s; end
  def value; end
  def write(output = T.unsafe(nil), indent = T.unsafe(nil), transitive = T.unsafe(nil), ie_hack = T.unsafe(nil)); end
end

class REXML::Child
  include ::REXML::Node

  def initialize(parent = T.unsafe(nil)); end

  def bytes; end
  def document; end
  def next_sibling; end
  def next_sibling=(other); end
  def parent; end
  def parent=(other); end
  def previous_sibling; end
  def previous_sibling=(other); end
  def remove; end
  def replace_with(child); end
end

class REXML::Comment < ::REXML::Child
  include ::Comparable

  def initialize(first, second = T.unsafe(nil)); end

  def <=>(other); end
  def ==(other); end
  def clone; end
  def node_type; end
  def string; end
  def string=(_arg0); end
  def to_s; end
  def write(output, indent = T.unsafe(nil), transitive = T.unsafe(nil), ie_hack = T.unsafe(nil)); end
end

module REXML::DClonable; end

class REXML::Declaration < ::REXML::Child
  def initialize(src); end

  def to_s; end
  def write(output, indent); end
end

class REXML::DocType < ::REXML::Parent
  include ::REXML::XMLTokens

  def initialize(first, parent = T.unsafe(nil)); end

  def add(child); end
  def attribute_of(element, attribute); end
  def attributes_of(element); end
  def clone; end
  def context; end
  def entities; end
  def entity(name); end
  def external_id; end
  def name; end
  def namespaces; end
  def node_type; end
  def notation(name); end
  def notations; end
  def public; end
  def system; end
  def write(output, indent = T.unsafe(nil), transitive = T.unsafe(nil), ie_hack = T.unsafe(nil)); end
end

class REXML::Document < ::REXML::Element
  def initialize(source = T.unsafe(nil), context = T.unsafe(nil)); end

  def <<(child); end
  def add(child); end
  def add_element(arg = T.unsafe(nil), arg2 = T.unsafe(nil)); end
  def clone; end
  def doctype; end
  def document; end
  def encoding; end
  def entity_expansion_count; end
  def expanded_name; end
  def name; end
  def node_type; end
  def record_entity_expansion; end
  def root; end
  def stand_alone?; end
  def version; end
  def write(*arguments); end
  def xml_decl; end

  private

  def build(source); end

  class << self
    def entity_expansion_limit; end
    def entity_expansion_limit=(val); end
    def entity_expansion_text_limit; end
    def entity_expansion_text_limit=(val); end
    def parse_stream(source, listener); end
  end
end

class REXML::Element < ::REXML::Parent
  include ::REXML::XMLTokens
  include ::REXML::Namespace

  def initialize(arg = T.unsafe(nil), parent = T.unsafe(nil), context = T.unsafe(nil)); end

  def [](name_or_index); end
  def add_attribute(key, value = T.unsafe(nil)); end
  def add_attributes(hash); end
  def add_element(element, attrs = T.unsafe(nil)); end
  def add_namespace(prefix, uri = T.unsafe(nil)); end
  def add_text(text); end
  def attribute(name, namespace = T.unsafe(nil)); end
  def attributes; end
  def cdatas; end
  def clone; end
  def comments; end
  def context; end
  def context=(_arg0); end
  def delete_attribute(key); end
  def delete_element(element); end
  def delete_namespace(namespace = T.unsafe(nil)); end
  def document; end
  def each_element(xpath = T.unsafe(nil), &block); end
  def each_element_with_attribute(key, value = T.unsafe(nil), max = T.unsafe(nil), name = T.unsafe(nil), &block); end
  def each_element_with_text(text = T.unsafe(nil), max = T.unsafe(nil), name = T.unsafe(nil), &block); end
  def elements; end
  def get_elements(xpath); end
  def get_text(path = T.unsafe(nil)); end
  def has_attributes?; end
  def has_elements?; end
  def has_text?; end
  def ignore_whitespace_nodes; end
  def inspect; end
  def instructions; end
  def namespace(prefix = T.unsafe(nil)); end
  def namespaces; end
  def next_element; end
  def node_type; end
  def prefixes; end
  def previous_element; end
  def raw; end
  def root; end
  def root_node; end
  def text(path = T.unsafe(nil)); end
  def text=(text); end
  def texts; end
  def whitespace; end
  def write(output = T.unsafe(nil), indent = T.unsafe(nil), transitive = T.unsafe(nil), ie_hack = T.unsafe(nil)); end
  def xpath; end

  private

  def __to_xpath_helper(node); end
  def each_with_something(test, max = T.unsafe(nil), name = T.unsafe(nil)); end
end

class REXML::ElementDecl < ::REXML::Declaration
  def initialize(src); end
end

class REXML::Elements
  include ::Enumerable

  def initialize(parent); end

  def <<(element = T.unsafe(nil)); end
  def [](index, name = T.unsafe(nil)); end
  def []=(index, element); end
  def add(element = T.unsafe(nil)); end
  def collect(xpath = T.unsafe(nil)); end
  def delete(element); end
  def delete_all(xpath); end
  def each(xpath = T.unsafe(nil)); end
  def empty?; end
  def index(element); end
  def inject(xpath = T.unsafe(nil), initial = T.unsafe(nil)); end
  def parent; end
  def size; end
  def to_a(xpath = T.unsafe(nil)); end

  private

  def literalize(name); end
end

module REXML::Encoding
  def decode(string); end
  def encode(string); end
  def encoding; end
  def encoding=(encoding); end

  private

  def find_encoding(name); end
end

class REXML::Entity < ::REXML::Child
  include ::REXML::XMLTokens

  def initialize(stream, value = T.unsafe(nil), parent = T.unsafe(nil), reference = T.unsafe(nil)); end

  def external; end
  def name; end
  def ndata; end
  def normalized; end
  def pubid; end
  def ref; end
  def to_s; end
  def unnormalized; end
  def value; end
  def write(out, indent = T.unsafe(nil)); end

  class << self
    def matches?(string); end
  end
end

class REXML::ExternalEntity < ::REXML::Child
  def initialize(src); end

  def to_s; end
  def write(output, indent); end
end

class REXML::Formatters::Default
  def initialize(ie_hack = T.unsafe(nil)); end

  def write(node, output); end

  protected

  def write_cdata(node, output); end
  def write_comment(node, output); end
  def write_document(node, output); end
  def write_element(node, output); end
  def write_instruction(node, output); end
  def write_text(node, output); end
end

class REXML::Formatters::Pretty < ::REXML::Formatters::Default
  def initialize(indentation = T.unsafe(nil), ie_hack = T.unsafe(nil)); end

  def compact; end
  def compact=(_arg0); end
  def width; end
  def width=(_arg0); end

  protected

  def write_cdata(node, output); end
  def write_comment(node, output); end
  def write_document(node, output); end
  def write_element(node, output); end
  def write_text(node, output); end

  private

  def indent_text(string, level = T.unsafe(nil), style = T.unsafe(nil), indentfirstline = T.unsafe(nil)); end
  def wrap(string, width); end
end

class REXML::IOSource < ::REXML::Source
  def initialize(arg, block_size = T.unsafe(nil), encoding = T.unsafe(nil)); end

  def consume(pattern); end
  def current_line; end
  def empty?; end
  def match(pattern, cons = T.unsafe(nil)); end
  def position; end
  def read; end
  def scan(pattern, cons = T.unsafe(nil)); end

  private

  def encoding_updated; end
  def readline; end
end

class REXML::Instruction < ::REXML::Child
  def initialize(target, content = T.unsafe(nil)); end

  def ==(other); end
  def clone; end
  def content; end
  def content=(_arg0); end
  def inspect; end
  def node_type; end
  def target; end
  def target=(_arg0); end
  def write(writer, indent = T.unsafe(nil), transitive = T.unsafe(nil), ie_hack = T.unsafe(nil)); end
end

class REXML::NotationDecl < ::REXML::Child
  def initialize(name, middle, pub, sys); end

  def name; end
  def public; end
  def public=(_arg0); end
  def system; end
  def system=(_arg0); end
  def to_s; end
  def write(output, indent = T.unsafe(nil)); end
end

class REXML::Output
  include ::REXML::Encoding

  def initialize(real_IO, encd = T.unsafe(nil)); end

  def <<(content); end
  def encoding; end
  def to_s; end
end

class REXML::Parent < ::REXML::Child
  include ::Enumerable

  def initialize(parent = T.unsafe(nil)); end

  def <<(object); end
  def [](index); end
  def []=(*args); end
  def add(object); end
  def children; end
  def deep_clone; end
  def delete(object); end
  def delete_at(index); end
  def delete_if(&block); end
  def each(&block); end
  def each_child(&block); end
  def each_index(&block); end
  def index(child); end
  def insert_after(child1, child2); end
  def insert_before(child1, child2); end
  def length; end
  def parent?; end
  def push(object); end
  def replace_child(to_replace, replacement); end
  def size; end
  def to_a; end
  def unshift(object); end
end

class REXML::ParseException < ::RuntimeError
  def initialize(message, source = T.unsafe(nil), parser = T.unsafe(nil), exception = T.unsafe(nil)); end

  def context; end
  def continued_exception; end
  def continued_exception=(_arg0); end
  def line; end
  def parser; end
  def parser=(_arg0); end
  def position; end
  def source; end
  def source=(_arg0); end
  def to_s; end
end

class REXML::Parsers::BaseParser
  def initialize(source); end

  def add_listener(listener); end
  def empty?; end
  def entity(reference, entities); end
  def has_next?; end
  def normalize(input, entities = T.unsafe(nil), entity_filter = T.unsafe(nil)); end
  def peek(depth = T.unsafe(nil)); end
  def position; end
  def pull; end
  def source; end
  def stream=(source); end
  def unnormalize(string, entities = T.unsafe(nil), filter = T.unsafe(nil)); end
  def unshift(token); end

  private

  def need_source_encoding_update?(xml_declaration_encoding); end
  def parse_attributes(prefixes, curr_ns); end
  def parse_id(base_error_message, accept_external_id:, accept_public_id:); end
  def parse_id_invalid_details(accept_external_id:, accept_public_id:); end
  def parse_name(base_error_message); end
  def process_instruction; end
  def pull_event; end
end

REXML::Parsers::BaseParser::EXTERNAL_ID_PUBLIC = T.let(T.unsafe(nil), Regexp)
REXML::Parsers::BaseParser::EXTERNAL_ID_SYSTEM = T.let(T.unsafe(nil), Regexp)
REXML::Parsers::BaseParser::PUBLIC_ID = T.let(T.unsafe(nil), Regexp)
REXML::Parsers::BaseParser::QNAME = T.let(T.unsafe(nil), Regexp)
REXML::Parsers::BaseParser::QNAME_STR = T.let(T.unsafe(nil), String)

class REXML::Parsers::StreamParser
  def initialize(source, listener); end

  def add_listener(listener); end
  def parse; end
end

class REXML::Parsers::TreeParser
  def initialize(source, build_context = T.unsafe(nil)); end

  def add_listener(listener); end
  def parse; end
end

class REXML::Parsers::XPathParser
  include ::REXML::XMLTokens

  def abbreviate(path); end
  def expand(path); end
  def namespaces=(namespaces); end
  def parse(path); end
  def predicate(path); end
  def predicate_to_string(path, &block); end

  private

  def AdditiveExpr(path, parsed); end
  def AndExpr(path, parsed); end
  def EqualityExpr(path, parsed); end
  def FilterExpr(path, parsed); end
  def FunctionCall(rest, parsed); end
  def LocationPath(path, parsed); end
  def MultiplicativeExpr(path, parsed); end
  def NodeTest(path, parsed); end
  def OrExpr(path, parsed); end
  def PathExpr(path, parsed); end
  def Predicate(path, parsed); end
  def PrimaryExpr(path, parsed); end
  def RelationalExpr(path, parsed); end
  def RelativeLocationPath(path, parsed); end
  def UnaryExpr(path, parsed); end
  def UnionExpr(path, parsed); end
  def get_group(string); end
  def parse_args(string); end
end

REXML::Parsers::XPathParser::LOCAL_NAME_WILDCARD = T.let(T.unsafe(nil), Regexp)
REXML::Parsers::XPathParser::PREFIX_WILDCARD = T.let(T.unsafe(nil), Regexp)

class REXML::ReferenceWriter
  def initialize(id_type, public_id_literal, system_literal, context = T.unsafe(nil)); end

  def write(output); end
end

class REXML::Source
  include ::REXML::Encoding

  def initialize(arg, encoding = T.unsafe(nil)); end

  def buffer; end
  def consume(pattern); end
  def current_line; end
  def empty?; end
  def encoding; end
  def encoding=(enc); end
  def line; end
  def match(pattern, cons = T.unsafe(nil)); end
  def match_to(char, pattern); end
  def match_to_consume(char, pattern); end
  def position; end
  def read; end
  def scan(pattern, cons = T.unsafe(nil)); end

  private

  def detect_encoding; end
  def encoding_updated; end
end

class REXML::Text < ::REXML::Child
  include ::Comparable

  def initialize(arg, respect_whitespace = T.unsafe(nil), parent = T.unsafe(nil), raw = T.unsafe(nil), entity_filter = T.unsafe(nil), illegal = T.unsafe(nil)); end

  def <<(to_append); end
  def <=>(other); end
  def clone; end
  def doctype; end
  def empty?; end
  def indent_text(string, level = T.unsafe(nil), style = T.unsafe(nil), indentfirstline = T.unsafe(nil)); end
  def inspect; end
  def node_type; end
  def parent=(parent); end
  def raw; end
  def raw=(_arg0); end
  def to_s; end
  def value; end
  def value=(val); end
  def wrap(string, width, addnewline = T.unsafe(nil)); end
  def write(writer, indent = T.unsafe(nil), transitive = T.unsafe(nil), ie_hack = T.unsafe(nil)); end
  def write_with_substitution(out, input); end
  def xpath; end

  private

  def clear_cache; end

  class << self
    def check(string, pattern, doctype); end
    def expand(ref, doctype, filter); end
    def normalize(input, doctype = T.unsafe(nil), entity_filter = T.unsafe(nil)); end
    def read_with_substitution(input, illegal = T.unsafe(nil)); end
    def unnormalize(string, doctype = T.unsafe(nil), filter = T.unsafe(nil), illegal = T.unsafe(nil)); end
  end
end

class REXML::UndefinedNamespaceException < ::REXML::ParseException
  def initialize(prefix, source, parser); end
end

class REXML::Validation::ValidationException < ::RuntimeError
  def initialize(msg); end
end

class REXML::XMLDecl < ::REXML::Child
  include ::REXML::Encoding

  def initialize(version = T.unsafe(nil), encoding = T.unsafe(nil), standalone = T.unsafe(nil)); end

  def ==(other); end
  def clone; end
  def dowrite; end
  def encoding=(enc); end
  def inspect; end
  def node_type; end
  def nowrite; end
  def old_enc=(encoding); end
  def stand_alone?; end
  def standalone; end
  def standalone=(_arg0); end
  def version; end
  def version=(_arg0); end
  def write(writer, indent = T.unsafe(nil), transitive = T.unsafe(nil), ie_hack = T.unsafe(nil)); end
  def writeencoding; end
  def writethis; end
  def xmldecl(version, encoding, standalone); end

  private

  def content(enc); end

  class << self
    def default; end
  end
end

class REXML::XPathNode
  def initialize(node, context = T.unsafe(nil)); end

  def context; end
  def position; end
  def raw_node; end
end

class REXML::XPathParser
  include ::REXML::XMLTokens

  def initialize(strict: T.unsafe(nil)); end

  def []=(variable_name, value); end
  def first(path_stack, node); end
  def get_first(path, nodeset); end
  def match(path_stack, nodeset); end
  def namespaces=(namespaces = T.unsafe(nil)); end
  def parse(path, nodeset); end
  def predicate(path, nodeset); end
  def variables=(vars = T.unsafe(nil)); end

  private

  def child(nodeset); end
  def compare(a, operator, b); end
  def descendant(nodeset, include_self); end
  def descendant_recursive(raw_node, new_nodeset, new_nodes, include_self); end
  def each_unnode(nodeset); end
  def enter(tag, *args); end
  def equality_relational_compare(set1, op, set2); end
  def evaluate_predicate(expression, nodesets); end
  def expr(path_stack, nodeset, context = T.unsafe(nil)); end
  def filter_nodeset(nodeset); end
  def following(node); end
  def following_node_of(node); end
  def get_namespace(node, prefix); end
  def leave(tag, *args); end
  def next_sibling_node(node); end
  def node_test(path_stack, nodesets, any_type: T.unsafe(nil)); end
  def norm(b); end
  def normalize_compare_values(a, operator, b); end
  def preceding(node); end
  def preceding_node_of(node); end
  def sort(array_of_nodes, order); end
  def step(path_stack, any_type: T.unsafe(nil), order: T.unsafe(nil)); end
  def strict?; end
  def trace(*args); end
  def unnode(nodeset); end
  def value_type(value); end
end
