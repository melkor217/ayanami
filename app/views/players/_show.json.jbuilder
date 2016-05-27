json.extract! player, :playerId, :lastName, :kills, :deaths, :headshots, :activity, :connection_time, :ranking
if player[:kpd]
  json.extract! player, :kpd
end
json.url player_path(player, format: :json)
json.path player_path(player)
json.avatarIcon player.unique_ids.first.avatar_icon
json.skill do
  json.points player.skill
  json.last_change player.last_skill_change
end