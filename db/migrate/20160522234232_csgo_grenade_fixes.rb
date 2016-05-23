class CsgoGrenadeFixes < ActiveRecord::Migration[5.0]
  def up
    Weapon.where(game: :csgo, code: :inferno).delete_all
    Weapon.find_or_create_by(game: :csgo, code: :incgrenade) do |weapon|
      weapon.name = 'Incendiary grenade'
      weapon.modifier = 1.8
    end
    Weapon.find_or_create_by(game: :csgo, code: :molotov) do |weapon|
      weapon.name = 'Molotov cocktail'
      weapon.modifier = 1.8
    end
    Weapon.find_or_create_by(game: :csgo, code: :hegrenade) do |weapon|
      weapon.name = 'HE grenade'
      weapon.modifier = 1.8
    end
  end
end
