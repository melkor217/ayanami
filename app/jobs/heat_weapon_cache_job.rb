class HeatWeaponCacheJob < ApplicationJob
  queue_as :default

  def perform
    Weapon.all.each do |weapon|
      weapon.frags_grouped(force: true)
      sleep 0.3
    end
  end
end
