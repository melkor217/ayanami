class PlayersAddMmrank < ActiveRecord::Migration[5.0]
  def change
    add_column :hlstats_Players , :mmrank, :int, limit: 4
  end
end
