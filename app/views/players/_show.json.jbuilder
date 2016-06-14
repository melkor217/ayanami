uniqueid = player.cached_unique_id

json.extract! player, :playerId, :lastName, :kills, :deaths, :headshots, :activity, :connection_time, :ranking
json.url player_path(player, format: :json)
json.path player_url(player)
json.pathname player_path(player)
if player[:kpd]
  json.extract! player, :kpd
end
json.avatarIcon avatar_url(uniqueid.avatar_icon)
json.skill do
  json.points player.skill
  json.last_change player.last_skill_change
end
json.steamUrl SteamId.steam_profile_url(uniqueid.uniqueId).to_s

if (clan = player.cached_team)
  json.clan do
    json.name clan.name
    json.clanId clan.clanId
    json.path clan_url(clan)
  end
end
