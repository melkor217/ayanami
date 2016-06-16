class ClanAddCalculatedAt < ActiveRecord::Migration[5.0]
  def change
    add_column :hlstats_Clans, :members_calculated_at, :datetime, default: nil
  end
end
