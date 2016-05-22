json.rows do
  json.array!(@killstats) do |playerId, stats|
    json.kills stats[:kills]
    json.deaths stats[:deaths]
    json.kpd stats[:kpd]
    json.avatarIcon Player.find(playerId).unique_ids.first.avatar_icon
    json.lastName Player.find(playerId).lastName
    json.url player_path(Player.find(playerId), format: :json)
    json.path player_path(Player.find(playerId))
  end
end

json.total @total
