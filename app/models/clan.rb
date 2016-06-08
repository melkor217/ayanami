class Clan < ApplicationRecord
  self.table_name = "hlstats_Clans" # MySQL table name

  has_many :players, foreign_key: :clan, primary_key: :clanId
  #accepts_nested_attributes_for :players
end
