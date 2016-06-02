class PlayerAddTimeColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :hlstats_PlayerUniqueIds , :created_at, :datetime
    add_column :hlstats_PlayerUniqueIds , :updated_at, :datetime
  end
end
