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
    return %w{kills deaths lastname activity skill playerId lastName kpd headshots}
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
  scope :with_kpd, -> { select('*, kills / deaths as kpd') }
  # Stewpid query, but i don't really wanna change legacy scheme
  scope :by_country, -> { select('flag, country, count(playerId) as players_total, avg(activity) as avg_activity').where(hideranking: 0).where.not(flag: "").group(:flag) }
  scope :name_search, ->(name) { where('lastName LIKE :query', query: "%#{name}%") }
  scope :country_search, ->(name) { where('country LIKE :query or flag LIKE :query', query: "%#{name}%") }

  belongs_to :country, foreign_key: :country, primary_key: :name

end
