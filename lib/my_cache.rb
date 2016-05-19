class MyCache
  def self.fetch(options = nil, &block)
    if options && options[:refresh]
      # option forces recalculation of the cache value
      force_refresh = true
      options.delete(:refresh)
    end
    if force_refresh
      a = yield
      Rails.cache.write(yield, options)
    else
      Rails.cache.fetch(options, &block)
    end
  end
end