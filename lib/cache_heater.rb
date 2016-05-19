class CacheHeater
  def self.run
    Weapon.all.each do |weapon|
      weapon.frags_grouped(refresh: true)
    end
  end
end