class CsgoFixSg553Name < ActiveRecord::Migration[5.0]
  def up
    Weapon.where(game: :csgo, code: :sg553).update_all(code: :sg556)
  end
end
