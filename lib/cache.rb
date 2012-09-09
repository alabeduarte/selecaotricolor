class Cache
  def self.fetch(args, cache=Rails.cache)
    limit = args[:expires_in] || 30.minutes
    cache.fetch(args[:key], expires_in: limit) { yield }
  end

  def self.write(args, cache=Rails.cache)
    cache.write(args[:key], args[:data])
  end
end
