# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   tapioca sync

# typed: true

class ConnectionPool
  def initialize(options = _, &block); end

  def available; end
  def checkin; end
  def checkout(options = _); end
  def shutdown(&block); end
  def size; end
  def with(options = _); end

  def self.wrap(options, &block); end
end

ConnectionPool::DEFAULTS = T.let(T.unsafe(nil), Hash)

class ConnectionPool::Error < ::RuntimeError
end

class ConnectionPool::PoolShuttingDownError < ::ConnectionPool::Error
end

class ConnectionPool::TimedStack
  def initialize(size = _, &block); end

  def <<(obj, options = _); end
  def empty?; end
  def length; end
  def max; end
  def pop(timeout = _, options = _); end
  def push(obj, options = _); end
  def shutdown(&block); end

  private

  def connection_stored?(options = _); end
  def current_time; end
  def fetch_connection(options = _); end
  def shutdown_connections(options = _); end
  def store_connection(obj, options = _); end
  def try_create(options = _); end
end

class ConnectionPool::TimeoutError < ::Timeout::Error
end

ConnectionPool::VERSION = T.let(T.unsafe(nil), String)

class ConnectionPool::Wrapper < ::BasicObject
  def initialize(options = _, &block); end

  def method_missing(name, *args, &block); end
  def pool_available; end
  def pool_shutdown(&block); end
  def pool_size; end
  def respond_to?(id, *args); end
  def with(&block); end
  def wrapped_pool; end
end

ConnectionPool::Wrapper::METHODS = T.let(T.unsafe(nil), Array)
