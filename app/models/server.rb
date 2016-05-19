class Server < ActiveRecord::Base
  self.table_name = "hlstats_Servers" # MySQL table name

  has_many :frags, foreign_key: :serverId, primary_key: :serverId
  has_one :game, foreign_key: :code, primary_key: :game
end
