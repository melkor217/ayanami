class HeatWeaponCacheJob < ApplicationJob
  sidekiq_options unique: :until_and_while_executing
  queue_as :default

  def perform
    Weapon.all.each do |weapon|
      puts weapon.code
      weapon.frags_grouped(force: true)
    end
  end
end
