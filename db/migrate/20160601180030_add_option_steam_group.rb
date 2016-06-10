class AddOptionSteamGroup < ActiveRecord::Migration[5.0]
  def up
    Option.create(keyname: 'steamgroup', value: 'reijii-dm', opttype: 2)
  end
  def down
    Option.where(keyname: 'steamgroup').delete_all
  end
end
