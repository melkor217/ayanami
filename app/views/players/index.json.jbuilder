json.rows do
  json.array!(@players) do |player|
    json.extract! player, :playerId, :lastName, :kills, :deaths, :kpd, :headshots, :activity, :connection_time, :ranking
    json.url player_path(player, format: :json)
    json.path player_path(player)
    json.skill do
      json.points player.skill
      json.last_change player.last_skill_change
    end
  end
end

json.total @total
