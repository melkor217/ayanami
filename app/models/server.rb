class Server < ActiveRecord::Base
  self.table_name = "hlstats_Servers" # MySQL table name

  def self.cache_find(id, options={})
    Rails.cache.fetch({mode: :server, id: id}, options) do
      Server.find(id)
    end
  end

  def livestats_players
    Livestats.where(server_id: self.serverId).where.not(steam_id: 'BOT')
  end

  has_many :frags, foreign_key: :serverId, primary_key: :serverId
  belongs_to :games, foreign_key: :code, primary_key: :game
end
