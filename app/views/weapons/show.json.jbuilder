#json.extract! @weapon, :name, :modifier, :kills, :headshots, :game
json.params params
json.rows do
  json.array!(@frags) do |k|
    json.playerId k.first
    player = Player.cache_find(k.first)
    json.lastName player.lastName
    json.url player_path(player, format: :json)
    json.path player_path(player)
    json.frags k.last
  end
end
json.total @total
