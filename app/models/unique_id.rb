class UniqueId < ActiveRecord::Base
  self.table_name = "hlstats_PlayerUniqueIds" # MySQL table name

  belongs_to :player, foreign_key: :playerId, primary_key: :playerId
end
