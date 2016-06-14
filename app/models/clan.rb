class Clan < ApplicationRecord
  # Please use Team class instead of this
  self.table_name = "hlstats_Clans" # MySQL table name

  def self.sort_allowed?
    # Fields that are allowed for sorting
    return %w{name homepage game hidden mapregion skill kills headshots deaths members}
  end

  def self.sort_default
    # Default sorting field
    return 'skill'
  end
end
