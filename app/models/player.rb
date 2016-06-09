class Player < ActiveRecord::Base

  self.table_name = "hlstats_Players" # MySQL table name


  def self.sort_allowed?
    # Fields that are allowed for sorting
    return %w{kills deaths lastname activity skill playerId lastName kpd headshots connection_time}
  end

  def self.sort_default
    # Default sorting field
    return 'skill'
  end

  def self.sort_allowed_by_country?
    return %w{players_total avg_activity avg_skill avg_kills avg_connection_time kpd flag country}
  end

  def self.sort_default_by_country
    return 'players_total'
  end

  scope :uniorder, -> (sort, order) { order("#{sort} #{order}") }
  scope :with_kpd, -> { select('*, round((kills / deaths),2) as kpd') }

  def cached_unique_id(options = {})
    options.merge!(expires_in: 10.minutes)
    Rails.cache.fetch({mode: :player_uid, playerId: self.playerId}, options) do
      unique_ids.first
    end
  end

  def cached_country(options = {})
    options.merge!(expires_in: 6.hours)
    Rails.cache.fetch({mode: :country, country: self.flag}, options) do
      self.country
    end
  end

  def self.cached_minimum(column, options = {})
    options.merge!(expires: 15.minutes)
    Rails.cache.fetch({mode: :players_min, column: column}, options) do
      self.minimum(column)
    end
  end

  def self.cached_maximum(column, options = {})
    options.merge!(expires: 15.minutes)
    Rails.cache.fetch({mode: :players_max, column: column}, options) do
      self.maximum(column)
    end
  end

  # Stewpid query, but i don't really wanna change legacy scheme
  # any_value for compat with  ONLY_FULL_GROUP_BY mode
  scope :by_country, -> { select('flag,
min(country) as country,
count(*) as players_total,
round(avg(connection_time)) as avg_connection_time,
round(avg(activity),2) as avg_activity,
round(avg(skill),2) as avg_skill,
round(avg(kills),2) as avg_kills,
round(sum(kills)/sum(deaths),2) as kpd
').where(hideranking: 0).where.not(flag: '').group(:flag) }
  scope :name_search, ->(name) { where('lastName LIKE :query', query: "%#{name}%") }
  scope :country_search, ->(name) { where('country LIKE :query or flag LIKE :query', query: "%#{name}%") }


  belongs_to :country, primary_key: :flag, foreign_key: :flag
  belongs_to :clan, primary_key: :clanId, foreign_key: :clan

  has_many :unique_ids, primary_key: :playerId, foreign_key: :playerId
  has_many :frag, foreign_key: :killerId, primary_key: :playerId

  def frag(game = nil)
    if game
      frags = Frag.all.by_game(game)
    else
      frags = Frag.all
    end
    frags.where("killerId = ? OR victimId = ?", self.playerId, self.playerId)
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
      result[k].merge!(kills: v, kpd: (v.to_f/[result[k][:deaths].to_i, 1].max).round(2))
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
    frags = self.frag('csgo').group(:weapon).group(:headshot).count.group_by do |k, _|
      k.first
      # {"ak47"=>[[["ak47", false], 1], [["ak47", true], 2]], "aug"=>[[["aug", false], 1], [["aug", true], 5]] }
    end
    weapons = []
    frags.each do |k, v|
      weapon = Weapon.readonly.find_by(code: k, game: 'csgo')
      weapon.kills = 0
      weapon.headshots = 0
      v.each do |r|
        weapon.kills += r.last
        if r.first.last == true
          weapon.headshots += r.last
        end
      end
      weapons.append weapon
    end
    return weapons
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
