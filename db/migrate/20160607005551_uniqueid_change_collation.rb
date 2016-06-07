class UniqueidChangeCollation < ActiveRecord::Migration[5.0]
  def up
    # for each table that will store unicode execute:
    execute "ALTER TABLE hlstats_PlayerUniqueIds CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;"
    # for each string/text column with unicode content execute:
  end
  def down
    # for each table that will store unicode execute:
    execute "ALTER TABLE hlstats_PlayerUniqueIds COLLATE utf8_general_ci;"
    # for each string/text column with unicode content execute:
  end
end
