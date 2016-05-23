class UniqueId < ActiveRecord::Base
  self.primary_keys = :uniqueId, :game
  self.table_name = "hlstats_PlayerUniqueIds" # MySQL table name

  def avatar_icon
    if self.avatarIcon == nil
      GetPlayerSteamInfoJob.set(queue: :urgent).perform_later(game: self.game, uniqueId: self.uniqueId)
      return nil
    else
      return self.avatarIcon
    end
  end

  belongs_to :player, foreign_key: :playerId, primary_key: :playerId
end
