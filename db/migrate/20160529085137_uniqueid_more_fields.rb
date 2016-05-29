class UniqueidMoreFields < ActiveRecord::Migration[5.0]
  def change
    add_column :hlstats_PlayerUniqueIds , :memberSince, :date
    add_column :hlstats_PlayerUniqueIds , :isLimitedAccount, :integer
    add_column :hlstats_PlayerUniqueIds , :location, :string
    add_column :hlstats_PlayerUniqueIds , :customURL, :string
    add_column :hlstats_PlayerUniqueIds , :realname, :string
  end
end
