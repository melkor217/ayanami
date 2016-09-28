class Latency < ApplicationRecord
  self.table_name = 'hlstats_Events_Latency' # MySQL table name

  belongs_to :player, primary_key: :playerId, foreign_key: :playerId
  scope :avg_value, -> do
    select('round(avg(ping)) as c').first.c.to_i
  end
end
