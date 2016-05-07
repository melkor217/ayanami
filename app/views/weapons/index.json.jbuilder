json.rows do
  json.array!(@weapons) do |weapon|
    json.extract! weapon, :weaponId, :game, :code, :name, :modifier, :kills, :headshots
    json.url weapon_url(weapon, format: :json)
    json.url weapon_url(weapon, format: :json)
    json.path weapon_url(weapon)
  end
end
