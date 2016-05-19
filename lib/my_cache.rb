class MyCache
  def self.fetch(name, options = nil, &block)
    if options && options[:refresh]
      # option forces recalculation of the cache value
      force_refresh = true
      options.delete(:refresh)
    end
    puts options
    if force_refresh
      a = yield
      Rails.cache.write(name, yield, options)
    else
      Rails.cache.fetch(name, options, &block)
    end
  end
end