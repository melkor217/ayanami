class ClanAddMembersCount < ActiveRecord::Migration[5.0]
  def change
    add_column :hlstats_Clans, :members, :integer, default: 0
    add_column :hlstats_Clans, :created_at, :datetime
    add_column :hlstats_Clans, :updated_at, :datetime
  end
end
