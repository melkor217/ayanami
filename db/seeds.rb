# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

SKILL_RATIO_CAP = 1
SKILL_MAX_CHANGE = 25
SKILL_MIN_CHANGE = 2
SKILL_MODE = 0
PLAYER_MIN_KILLS = 50
DEFAULT_SKILL = 1000

def killer_skill_change(killer, victim, weapon)
  # From hlstats.pl, 17.05.2016
  if SKILL_RATIO_CAP > 0
    lowratio = 0.7
    highratio = 1.0 / lowratio
    ratio = victim.skill / killer.skill
    if ratio < lowratio
      ratio = lowratio
    end
    if ratio > highratio
      ratio = highratio
    end
    killer_skill_change = ratio * 5 * weapon.modifier
  else
    killer_skill_change = (victim.skill / killer.skill) * 5 * weapon.modifier
  end

  if killer_skill_change > SKILL_MAX_CHANGE
    killer_skill_change = SKILL_MAX_CHANGE
  end

  if killer_skill_change < SKILL_MIN_CHANGE
    killer_skill_change = SKILL_MIN_CHANGE
  end

  return killer_skill_change
end

def victim_skill_change(killer, victim, weapon)
  killer_skill_change = killer_skill_change(killer, victim, weapon)
  if SKILL_MODE == 0
    victim_skill_change = killer_skill_change
  elsif SKILL_MODE == 1
    victim_skill_change = killer_skill_change * 0.75
  elsif SKILL_MODE == 2
    victim_skill_change = killer_skill_change * 0.5
  elsif SKILL_MODE == 3
    victim_skill_change = killer_skill_change * 0.25
  elsif SKILL_MODE == 4
    victim_skill_change = killer_skill_change
    #elsif SKILL_MODE == 4
    # TODO: l4d stuff
  end

  if victim_skill_change > SKILL_MAX_CHANGE
    victim_skill_change = SKILL_MAX_CHANGE
  end

  if victim_skill_change < SKILL_MIN_CHANGE && SKILL_MODE != 4
    victim_skill_change = SKILL_MIN_CHANGE
  end

  if killer.kills < PLAYER_MIN_KILLS || victim.kills < PLAYER_MIN_KILLS
    if SKILL_MODE == 4
      victim_skill_change = 0
    else
      victim_skill_change = SKILL_MIN_CHANGE
    end
  end

  return victim_skill_change
end


def do_kill(killer, victim, weapon, server)
  headshot = rand(0..9)==0?0:1

  killer.skill += killer_skill_change(killer, victim, weapon)
  killer.kills += 1
  killer.connection_time += rand(2..20)
  if headshot == 1
    killer.headshots += 1
  end
  killer.save

  victim.skill -= victim_skill_change(killer, victim, weapon)
  victim.deaths += 1
  victim.connection_time += rand(2..20)
  victim.save

  weapon.kills += 1
  weapon.save
  if headshot == 1
    weapon.headshots += 1
  end
  weapon.save

  Frag.create(serverId: server.serverId,
              map: 'de_dust2',
              killerId: killer.playerId,
              victimId: victim.playerId,
              weapon: weapon.code,
              eventTime: rand(1.year.ago..Time.now),
              headshot: headshot)

end

112.times do
  player = Player.create do |player|
    player.game = 'csgo'
    player.lastName = (RandomWord.adjs.next.to_s + ' ' + RandomWord.nouns.next.to_s).titleize[0..63]
    player.activity = rand (0..100)
    player.skill = DEFAULT_SKILL
    player.connection_time = 0
    player.headshots = 0
    c = Country.all.sample
    player.country = c
    player.flag = c.flag
    player.last_skill_change = rand(-130..130)
  end

  UniqueId.create(player: player, uniqueId: player.playerId+999999, game: :csgo)
  UniqueId.create(player: player, uniqueId: player.playerId+999, game: :tf)
end

Game.where(hidden: '0').each do |game|
  (2..4).each do |c|
    Server.create(
        address: "#{game.code}#{c}.net",
        port: 27015,
        name: "#{game.code} server #{c}",
        sortorder: c,
        publicaddress: "1.2.3.#{c}:27015",
        rcon_password: 'test',
        game: game.code,
        kills: rand(100..1000),
        players: rand(1000..2000),
        headshots: rand(50..90),
        act_map: 'de_dust2',
        act_players: rand(8..12),
        max_players: 15)
  end
end
Player.all.each do |player|
  rand(0..20).times do
    random_player = Player.where.not(playerId: player.playerId).sample
    rand(1..5).times do
      server = Server.all.sample
      weapon = Weapon.where(game: server.game).sample
      rand(1..7).times do
        do_kill(player, random_player, weapon, server)
      end
    end
  end
end
