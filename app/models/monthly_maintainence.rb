class MonthlyMaintainence < ActiveRecord::Base
  attr_accessible :comment, :month, :name, :refnum, :total_due
end
