class UniqueidAddPersonaname < ActiveRecord::Migration[5.0]
  def change
    add_column :hlstats_PlayerUniqueIds , :personaname, :string
  end
end
