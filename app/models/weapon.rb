class Weapon < ActiveRecord::Base
  extend FriendlyId

  friendly_id :code
  def self.sort_allowed?
    # Fields that are allowed for sorting
    return %w{name modifier kills headshots}
  end
  def self.sort_default
    # Default sorting field
    return 'kills'
  end
  self.table_name = "hlstats_Weapons" # MySQL table name
  scope :name_search, ->(name) { where('name LIKE :query', query: "%#{name}%") }
  scope :uniorder, -> (sort, order) {order("#{sort} #{order}")}

  def frags_grouped(options = {})
    options.merge!(mode: :weapon, game: self.game, code: self.code, expires_in: 1.hours)
    puts options
    MyCache.fetch(:weapon, options) do
     Frag.where(weapon: self.code).by_game('csgo').group(:killerId).uniorder(:count_killerid, :desc).count(:killerId)
    end
  end

  has_many :frags, foreign_key: :weapon, primary_key: :code
end
