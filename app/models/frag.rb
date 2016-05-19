class Frag < ActiveRecord::Base
  paginates_per 50
  self.table_name = "hlstats_Events_Frags" # MySQL table name

  scope :uniorder, -> (sort, order) { order("#{sort} #{order}") }

  scope :by_game, -> (game) { Frag.joins(server: :games).where("hlstats_Games.code" => game) }

  belongs_to :server, primary_key: :serverId, foreign_key: :serverId
end
