class Weapon < ActiveRecord::Base
  def self.sort_allowed?
    # Fields that are allowed for sorting
    return %w{name modifier kills headshots}
  end
  def self.sort_default
    # Default sorting field
    return 'name'
  end
  self.table_name = "hlstats_Weapons" # MySQL table name
  scope :name_search, ->(name) { where('name LIKE :query', query: "%#{name}%") }
  scope :uniorder, -> (sort, order) {order("#{sort} #{order}")}
end
