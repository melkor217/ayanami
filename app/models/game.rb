class Game < ApplicationRecord
  extend FriendlyId
  friendly_id :code

  self.table_name = 'hlstats_Games'

  has_many :servers, foreign_key: :game, primary_key: :code
  has_many :weapons, foreign_key: :game, primary_key: :code
end
