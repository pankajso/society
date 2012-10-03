class MonthlyMaintainence < ActiveRecord::Base
  attr_accessible :comment, :month, :name, :refnum, :total_due

  def self.generate_maintainence(for_month)
    self.calculate_maintainence(for_month)
  end

  def self.calculate_maintainence(for_month)
    prev_maintainence = MonthlyMaintainence.find(:all, :conditions => ["month = ?", for_month - 1.month])
    return if prev_maintainence.empty?
    members = Member.find.all
    for member in members
      prev_amount_due = MonthlyMaintainence.find(:all, :conditions => ["month = ?", for_month - 1.month , "refnum = ?", member.refnum] )
      #TODO Calculate the Inwards for the same member from the previous months inwards 
      new_amount_due = prev_amount_due.amount + member.Rule.amount
    end
  end

  def self.calculate_member_maintainence(member)
    
  end
end
