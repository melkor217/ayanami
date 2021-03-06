class UpdateAvatarsJob < ApplicationJob
  queue_as :default

  def perform()
    UniqueId.where(steamUpdated: nil).order(playerId: :desc).limit(300).each do |id|
      GetPlayerSteamInfoJob.perform_later(game: id.game, uniqueId: id.uniqueId)
    end
    UniqueId.where('steamUpdated < ?', 3.days.ago).limit(30).each do |id|
      GetPlayerSteamInfoJob.perform_later(game: id.game, uniqueId: id.uniqueId)
    end
  end
end
