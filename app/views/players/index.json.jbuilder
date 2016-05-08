json.rows do
  json.array!(@players) do |player|
    json.extract! player, :playerId, :lastName, :skill, :kills, :deaths, :kpd, :headshots, :activity
    json.url player_path(player, format: :json)
    json.path player_path(player)
  end
end

json.total @total
