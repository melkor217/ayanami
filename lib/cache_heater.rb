class CacheHeater
  def self.run
    Weapon.all.each do |weapon|
      puts weapon.code
      weapon.frags_grouped(refresh: true)
    end
  end
end