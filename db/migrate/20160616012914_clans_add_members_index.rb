class ClansAddMembersIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :hlstats_Clans, :members_calculated_at, unique: false
    add_index :hlstats_Clans, :members, unique: false
  end
end
