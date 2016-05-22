class CacheHeater
  def self.run
    HeatWeaponCacheJob.perform_later
  end
end