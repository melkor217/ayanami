class UpdateAvatarsJob < ApplicationJob
  queue_as :default

  def perform()
    UniqueId.where(updated_at: nil).order(playerId: :desc).limit(300).each do |id|
      GetPlayerSteamInfoJob.perform_later(game: id.game, uniqueId: id.uniqueId)
    end
    UniqueId.where('updated_at < ?', 3.days.ago).limit(100).each do |id|
      GetPlayerSteamInfoJob.perform_later(game: id.game, uniqueId: id.uniqueId)
    end
  end
end
