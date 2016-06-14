json.rows do
  json.array!(@players) do |player|
    json.partial! 'players/show', player: player
  end
end

json.total @total
