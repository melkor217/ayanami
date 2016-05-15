class Frag < ActiveRecord::Base
  paginates_per 50
  self.table_name = "hlstats_Events_Frags" # MySQL table name

  scope :uniorder, -> (sort, order) { order("#{sort} #{order}") }
end
