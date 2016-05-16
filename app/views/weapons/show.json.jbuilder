#json.extract! @weapon, :name, :modifier, :kills, :headshots, :game
json.rows do
  json.array!(@frags) do |k|
    json.playerId k.first
    json.frags k.last
  end
end
json.total @total
