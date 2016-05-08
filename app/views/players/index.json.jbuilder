json.rows do
  json.array!(@players) do |player|
    json.extract! player, :playerId, :lastName, :kills, :deaths, :kpd, :headshots, :activity
    json.url player_path(player, format: :json)
    json.skill do
      json.points player.skill
      json.last_change player.last_skill_change
    end
    json.path player_path(player)
  end
end

json.total @total
