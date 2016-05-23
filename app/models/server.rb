class Server < ActiveRecord::Base
  self.table_name = "hlstats_Servers" # MySQL table name

  def self.cache_find(id, options={})
    Rails.cache.fetch({mode: :server, id: id}, options) do
      Server.find(id)
    end
  end

  has_many :frags, foreign_key: :serverId, primary_key: :serverId
  belongs_to :games, foreign_key: :code, primary_key: :game
end
