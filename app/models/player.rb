class Player < ActiveRecord::Base

  self.table_name = "hlstats_Players" # MySQL table name

  trigger.after(:update).of(:clan, :hideranking) do
    '
    BEGIN
      IF NEW.hideranking <> OLD.hideranking THEN
        IF NEW.hideranking = 0  THEN
          UPDATE hlstats_Clans SET members = members + 1 where clanId = OLD.clan;
        END IF;
        IF OLD.hideranking = 0  THEN
          UPDATE hlstats_Clans SET members = members - 1 where clanId = OLD.clan;
        END IF;
      END IF;
      IF NEW.clan <> OLD.clan THEN
        IF NEW.clan <> 0  THEN
          UPDATE hlstats_Clans SET members = members + 1 where clanId = NEW.clan;
        END IF;
        IF OLD.clan <> 0 THEN
          UPDATE hlstats_Clans SET members = members - 1 where clanId = OLD.clan;
        END IF;
      END IF;
    END;'
  end
  trigger.after(:insert) do
    '
    BEGIN
      IF NEW.clan <> 0 and NEW.hideranking = 0 THEN
        UPDATE hlstats_Clans SET members = members + 1 where clanId = NEW.clan;
      END IF;
    END;'
  end
  trigger.after(:delete) do
    '
    BEGIN
      IF OLD.clan <> 0 and OLD.hideranking = 0 THEN
        UPDATE hlstats_Clans SET members = members - 1 where clanId = OLD.clan;
      END IF;
    END;'
  end

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

  def cached_team(options = {})
    options.merge!(expires_in: 10.minutes)
    Rails.cache.fetch({mode: :player_clan, playerId: self.playerId}, options) do
      team
    end
  end

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
  scope :by_country, -> {
    select('any_value(flag) as flag,
any_value(country) as country,
count(*) as players_total,
round(avg(connection_time)) as avg_connection_time,
round(avg(activity),2) as avg_activity,
round(avg(skill),2) as avg_skill,
round(avg(kills),2) as avg_kills,
round(sum(kills)/sum(deaths),2) as kpd
').where.not(flag: '').group(:flag)
  }
  scope :by_team, -> (member_limit = 3) { select("avg(connection_time) as connection_time,
avg(activity) as activity,
avg(skill) as skill,
avg(kills) as kills,
avg(deaths) as deaths,
avg(last_skill_change) as last_skill_change,
avg(headshots) as headshots,
hlstats_Clans.members as members,
hlstats_Clans.tag as tag,
hlstats_Clans.name as name,
hlstats_Clans.homepage as homepage,
hlstats_Clans.mapregion as mapregion,
hlstats_Clans.clanId as clanId,
hlstats_Clans.game as game,
hlstats_Clans.hidden as hidden
").where(hideranking: 0).where.not(clan: 0).group(:clan).joins(:team).having('members >= ?', member_limit.to_i)
  }
  scope :name_search, ->(name) { where('lastName LIKE :query', query: "%#{name}%") }
  scope :country_search, ->(name) { where('country LIKE :query or flag LIKE :query', query: "%#{name}%") }


  belongs_to :country, primary_key: :flag, foreign_key: :flag
  belongs_to :team, primary_key: :clanId, foreign_key: :clan

  has_many :unique_ids, primary_key: :playerId, foreign_key: :playerId
  has_many :frag, foreign_key: :killerId, primary_key: :playerId
  has_many :chat, foreign_key: :playerId, primary_key: :playerId
  has_many :latencies, foreign_key: :playerId, primary_key: :playerId

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
    logger.warn frags
    weapons = []
    return weapons if not frags.count
    frags.each do |k, v|
      weapon = Weapon.readonly.find_by(code: k, game: 'csgo')
      if weapon
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
