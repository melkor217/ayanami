class Frag < ActiveRecord::Base
  self.table_name = "hlstats_Events_Frags" # MySQL table name

  scope :uniorder, -> (sort, order) {order("#{sort} #{order}")}
end
