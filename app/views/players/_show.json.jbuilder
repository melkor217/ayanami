json.extract! player, :playerId, :lastName, :kills, :deaths, :headshots, :activity, :connection_time, :ranking
if player[:kpd]
  json.extract! player, :kpd
end

uniqueid = player.unique_ids.first

json.url player_path(player, format: :json)
json.steamUrl SteamId.steam_profile_url(uniqueid.uniqueId).to_s
json.path player_path(player)
json.avatarIcon avatar_url(uniqueid.avatar_icon)
json.skill do
  json.points player.skill
  json.last_change player.last_skill_change
end
json.killstatsPath killstats_player_path(player)
json.weaponsPath weapons_player_path(player)
json.fragsPath player_frags_path(player)
if player.country
  json.country do
    json.partial! 'countries/show', country: player.country
  end
end
