class CreateSteamGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :steam_groups do |t|
      t.integer :groupID, index: true, limit: 8, null: false, unique: true
      t.string :groupName, index: true
      t.string :groupURL, index: true
      t.string :summary, limit: 2048
      t.string :avatarIcon
      t.string :avatarMedium
      t.string :avatarFull
      t.string :memberCount, index: true
      t.timestamps
    end
  end
end
