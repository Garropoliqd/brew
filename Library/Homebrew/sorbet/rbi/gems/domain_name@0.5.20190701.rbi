# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `domain_name` gem.
# Please instead update this file by running `tapioca generate --exclude json`.

# typed: true

class DomainName
  def initialize(hostname); end

  def <(other); end
  def <=(other); end
  def <=>(other); end
  def ==(other); end
  def >(other); end
  def >=(other); end
  def canonical?; end
  def canonical_tld?; end
  def cookie_domain?(domain, host_only = T.unsafe(nil)); end
  def domain; end
  def domain_idn; end
  def hostname; end
  def hostname_idn; end
  def idn; end
  def inspect; end
  def ipaddr; end
  def ipaddr?; end
  def superdomain; end
  def tld; end
  def tld_idn; end
  def to_s; end
  def to_str; end
  def uri_host; end

  class << self
    def etld_data; end
    def normalize(domain); end
  end
end

DomainName::DOT = T.let(T.unsafe(nil), String)

DomainName::ETLD_DATA = T.let(T.unsafe(nil), Hash)

DomainName::ETLD_DATA_DATE = T.let(T.unsafe(nil), String)

module DomainName::Punycode
  class << self
    def decode(string); end
    def decode_hostname(hostname); end
    def encode(string); end
    def encode_hostname(hostname); end
  end
end

class DomainName::Punycode::ArgumentError < ::ArgumentError
end

DomainName::Punycode::BASE = T.let(T.unsafe(nil), Integer)

class DomainName::Punycode::BufferOverflowError < ::DomainName::Punycode::ArgumentError
end

DomainName::Punycode::CUTOFF = T.let(T.unsafe(nil), Integer)

DomainName::Punycode::DAMP = T.let(T.unsafe(nil), Integer)

DomainName::Punycode::DECODE_DIGIT = T.let(T.unsafe(nil), Hash)

DomainName::Punycode::DELIMITER = T.let(T.unsafe(nil), String)

DomainName::Punycode::DOT = T.let(T.unsafe(nil), String)

DomainName::Punycode::ENCODE_DIGIT = T.let(T.unsafe(nil), Proc)

DomainName::Punycode::INITIAL_BIAS = T.let(T.unsafe(nil), Integer)

DomainName::Punycode::INITIAL_N = T.let(T.unsafe(nil), Integer)

DomainName::Punycode::LOBASE = T.let(T.unsafe(nil), Integer)

DomainName::Punycode::MAXINT = T.let(T.unsafe(nil), Integer)

DomainName::Punycode::PREFIX = T.let(T.unsafe(nil), String)

DomainName::Punycode::RE_NONBASIC = T.let(T.unsafe(nil), Regexp)

DomainName::Punycode::SKEW = T.let(T.unsafe(nil), Integer)

DomainName::Punycode::TMAX = T.let(T.unsafe(nil), Integer)

DomainName::Punycode::TMIN = T.let(T.unsafe(nil), Integer)

DomainName::VERSION = T.let(T.unsafe(nil), String)
