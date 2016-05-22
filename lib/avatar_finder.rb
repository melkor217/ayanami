class AvatarFinder
  def self.run
    UniqueId.where('steamUpdated < ?', 3.days.ago).or(UniqueId.where(steamUpdated: nil)).limit(50).each do |id|
      GetPlayerSteamInfoJob.perform_later(id)
    end
  end
end