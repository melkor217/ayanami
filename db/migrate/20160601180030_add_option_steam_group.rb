class AddOptionSteamGroup < ActiveRecord::Migration[5.0]
  def change
    Option.create(keyname: 'steamgroup', value: 'reijii-dm', opttype: 2)
  end
end
