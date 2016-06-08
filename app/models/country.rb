class Country < ActiveRecord::Base

  self.table_name = "hlstats_Countries" # MySQL table name

  has_many :players, foreign_key: :flag, primary_key: :flag
end
