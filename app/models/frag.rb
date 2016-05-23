class Frag < ActiveRecord::Base
  paginates_per 50
  self.table_name = "hlstats_Events_Frags" # MySQL table name

  scope :uniorder, -> (sort, order) { order("#{sort} #{order}") }

  scope :by_game, -> (game) do
    Frag.where(server: Server.where(game: game).pluck(:serverId))
  end

  has_one :server, primary_key: :serverId, foreign_key: :serverId
end
