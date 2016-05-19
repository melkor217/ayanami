class CacheHeater
  def self.run
    Weapon.all.each do |weapon|
      puts weapon.code
      weapon.frags_grouped(force: true)
    end
  end
end