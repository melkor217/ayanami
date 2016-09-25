json.rows do
  json.array!(@killstats) do |player_id, stats|
    player = Player.find(player_id)
    json.kills stats[:kills]
    json.deaths stats[:deaths]
    json.kpd stats[:kpd]
    json.avatarIcon avatar_url(player.unique_ids.first.avatar_icon)
    json.lastName player.lastName
    json.url player_path(player, format: :json)
    json.path player_path(player)
  end
end

json.total @total
