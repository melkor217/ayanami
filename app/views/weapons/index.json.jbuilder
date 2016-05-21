json.rows do
  json.array!(@weapons) do |weapon|
    json.extract! weapon, :weaponId, :game, :code, :name, :modifier, :kills, :headshots
    json.url weapon_path(weapon, format: :json)
    json.path weapon_path(weapon)
    json.icon asset_path("weapons/#{weapon.game}/1/#{weapon.code}.png")
  end
end

json.total @total
