class Rule < ActiveRecord::Base
  has_one :Member
  attr_accessible :amount, :rulename
end
