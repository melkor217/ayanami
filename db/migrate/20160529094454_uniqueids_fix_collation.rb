class UniqueidsFixCollation < ActiveRecord::Migration[5.0]
  def up
    change_column :hlstats_PlayerUniqueIds , :realname, "VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
  end
end
