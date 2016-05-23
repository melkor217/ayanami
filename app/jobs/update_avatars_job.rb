class UpdateAvatarsJob < ApplicationJob
  queue_as :default

  def perform()
    UniqueId.where(steamUpdated: nil).limit(300).each do |id|
      GetPlayerSteamInfoJob.perform_later(game: id.game, uniqueId: id.uniqueId)
    end
    UniqueId.where('steamUpdated < ?', 3.days.ago).limit(100).each do |id|
      GetPlayerSteamInfoJob.perform_later(game: id.game, uniqueId: id.uniqueId)
    end
  end
end
