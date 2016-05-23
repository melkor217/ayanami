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
  scope :uniorder, -> (sort, order) { order("#{sort} #{order}") }

  def frags_grouped(options = {})
    name = {mode: :weaponstats, game: self.game, code: self.code}
    Rails.cache.fetch(name, options) do
      Frag.joins(:server).where('hlstats_Servers.game' => self.game).where(weapon: self.code).group(:killerId).uniorder(:count_killerid, :desc).count(:killerId)
    end
  end

  def self.cache_find(code, game, options = {})
    Rails.cache.fetch({mode: :weapon, code: code, game: game}, options) do
      Weapon.find_by!(code: code, game: game)
    end
  end

  has_many :frags, foreign_key: :weapon, primary_key: :code
end
