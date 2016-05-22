class UniqueidAddAvatar < ActiveRecord::Migration[5.0]
  def change
    add_column :hlstats_PlayerUniqueIds , :steamUpdated, :datetime
    add_column :hlstats_PlayerUniqueIds , :avatarIcon, :string
    add_column :hlstats_PlayerUniqueIds , :avatarMedium, :string
    add_column :hlstats_PlayerUniqueIds , :avatarFull, :string
    add_column :hlstats_PlayerUniqueIds , :vacBanned, :int
  end
end
