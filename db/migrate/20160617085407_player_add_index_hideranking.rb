class PlayerAddIndexHideranking < ActiveRecord::Migration[5.0]
  def change
    add_index :hlstats_Players, [:hideranking, :flag], unique: false, name: :lel
  end
end
