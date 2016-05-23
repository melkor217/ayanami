class UpdateAvatarsJob < ApplicationJob
  queue_as :default

  def perform()
    UniqueId.where('steamUpdated < ?', 3.days.ago).or(UniqueId.where(steamUpdated: nil)).limit(100).each do |id|
      GetPlayerSteamInfoJob.perform_later(game: id.game, uniqueId: id.uniqueId)
    end
  end
end
