class Player < ActiveRecord::Base

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
    return %w{players_total avg_activity avg_skill avg_kills kpd flag country}
  end

  def self.sort_default_by_country
    return 'players_total'
  end

  scope :uniorder, -> (sort, order) { order("#{sort} #{order}") }
  scope :with_kpd, -> { select('*, round((kills / deaths),2) as kpd') }
  # Stewpid query, but i don't really wanna change legacy scheme
  scope :by_country, -> { select('flag,
country,
count(playerId) as players_total,
round(avg(connection_time)) as avg_connection_time,
round(avg(activity),2) as avg_activity,
round(avg(skill),2) as avg_skill,
round(avg(kills),2) as avg_kills,
round(sum(kills)/sum(deaths),2) as kpd
').where(hideranking: 0).where.not(flag: '').group(:flag) }
  scope :name_search, ->(name) { where('lastName LIKE :query', query: "%#{name}%") }
  scope :country_search, ->(name) { where('country LIKE :query or flag LIKE :query', query: "%#{name}%") }

  def country(options = {})
    options.merge!(expires_in: 6.hours)
    Rails.cache.fetch({mode: :country, country: self.flag}, options) do
      super
    end
  end

  has_one :country, foreign_key: :flag, primary_key: :flag
  has_many :frag, foreign_key: :killerId, primary_key: :playerId

  def frag
    Frag.where("killerId = ? OR victimId = ?", self.playerId, self.playerId)
  end

  def killstats
    kills = Frag.where(killerId: self.playerId).group(:victimId).count()
    deaths = Frag.where(victimId: self.playerId).group(:killerId).count()
    result = {}
    deaths.each do |k, v|
      if not result[k]
        result[k] = {}
      end
      result[k].merge!(deaths: v)
    end
    kills.each do |k, v|
      if not result[k]
        result[k] = {}
      end
      result[k].merge!(kills: v, kpd: v.to_f/[result[k][:deaths].to_i, 1].max)
    end
    return result
  end

  def self.cache_find(playerId, options = {})
    options.merge!(expires_in: 1.hours)
    Rails.cache.fetch({mode: :player, player: playerId}, options) do
      self.find(playerId)
    end
  end

  def weapons
    return self.frag.group(:weapon).count.transform_keys do |key|
      Weapon.find_by(code: key, game: 'csgo')
    end
  end

  def ranking(options = {})
    options.merge!(expires_in: 10.minutes)
    Rails.cache.fetch({mode: :rank, rank: self.skill}, options) do
      Player.where('skill > ?', self.skill).count + 1
    end
  end

  def self.total(options = {})
    options.merge!(expires: 10.minutes)
    Rails.cache.fetch({mode: :total_players}, options) do
      Player.count
    end
  end
end
