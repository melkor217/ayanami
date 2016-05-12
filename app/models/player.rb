class Player < ActiveRecord::Base
  if Rails.configuration.database_configuration[Rails.env]['adapter'] != 'mysql2'
    include Mongoid::Document
    field :flag, type: String
    field :name, type: String
  end

  self.table_name = "hlstats_Players" # MySQL table name
  alias_attribute :country_name, :country

  def self.sort_allowed?
    # Fields that are allowed for sorting
    return %w{kills deaths lastname activity skill playerId lastName kpd headshots connection_time}
  end
  def self.sort_default
    # Default sorting field
    return 'skill'
  end

  def self.sort_allowed_by_country?
    return %w{players_total avg_activity flag country}
  end

  def self.sort_default_by_country
    return 'players_total'
  end

  scope :uniorder, -> (sort, order) {order("#{sort} #{order}")}
  scope :with_kpd, -> { select('*, round((kills / deaths),2) as kpd') }
  # Stewpid query, but i don't really wanna change legacy scheme
  scope :by_country, -> { select('flag, country, count(playerId) as players_total, avg(activity) as avg_activity').where(hideranking: 0).where.not(flag: '').group(:flag) }
  scope :name_search, ->(name) { where('lastName LIKE :query', query: "%#{name}%") }
  scope :country_search, ->(name) { where('country LIKE :query or flag LIKE :query', query: "%#{name}%") }

  def country
    Rails.cache.fetch("country_#{self.flag}", expires_in: 1.day) do
      super
    end
  end

  belongs_to :country, foreign_key: :flag, primary_key: :flag
  has_many :frag, foreign_key: :killerId, primary_key: :playerId
  def frag
    Frag.where("killerId = ? OR victimId = ?", self.playerId, self.playerId)
  end
end
