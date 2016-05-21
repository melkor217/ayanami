class CsgoAddM4a1Silcencer < ActiveRecord::Migration[5.0]
  def up
    Weapon.find_or_create_by(game: :csgo, code: :m4a1_silencer) do |weapon|
      weapon.name = 'M4A1-S'
      weapon.modifier = 1.05
    end
  end
  def down
     Weapon.where(code: :m4a1_silencer).destroy_all
  end
end

