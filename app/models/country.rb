class Country < ActiveRecord::Base
  if Rails.configuration.database_configuration[Rails.env]['adapter'] != 'mysql2'
    include Mongoid::Document
    field :flag, type: String
    field :name, type: String
  end

  self.table_name = "hlstats_Countries" # MySQL table name

  has_many :players
end
