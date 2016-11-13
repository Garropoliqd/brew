module Enumerable
  unless method_defined?(:flat_map)
    def flat_map
      return to_enum(:flat_map) unless block_given?
      r = []
      each do |*args|
        result = yield(*args)
        result.respond_to?(:to_ary) ? r.concat(result) : r.push(result)
      end
      r
    end
  end
end
