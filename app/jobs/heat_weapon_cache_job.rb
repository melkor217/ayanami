class HeatWeaponCacheJob < ApplicationJob
  queue_as :default

  def perform
    Weapon.all.each do |weapon|
      puts weapon.code
      weapon.frags_grouped(force: true)
    end
  end
end
