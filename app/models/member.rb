class Member < ActiveRecord::Base
  has_one :Rule
  attr_accessible :contactno, :email, :name, :refnum
end
