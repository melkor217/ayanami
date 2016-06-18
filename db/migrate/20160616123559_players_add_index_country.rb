class PlayersAddIndexCountry < ActiveRecord::Migration[5.0]
  def change
    add_index :hlstats_Players, :flag, unique: false
  end
end
