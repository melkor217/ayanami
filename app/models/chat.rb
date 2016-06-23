class Chat < ApplicationRecord
  self.table_name = "hlstats_Events_Chat" # MySQL table name
  belongs_to :player, primary_key: :playerId, foreign_key: :playerId
end
