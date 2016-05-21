class CsgoRemoveBrokenGalil < ActiveRecord::Migration[5.0]
  def up
    Weapon.where(game: :csgo, code: :galil).delete_all
  end
end
