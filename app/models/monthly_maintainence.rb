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
      #TODO Also consider the adjustments, extra charges for this month if any
      #TODO Also if member had paid his dues in advance then also display / add the comments => need to figure out how this will be done  
      new_amount_due = prev_amount_due.amount + member.Rule.amount
      begin
        record = MonthlyMaintainence.new(:refnum => member.refnum, :name => member.name, :month => for_month, :total_due => new_amount_due)
        record.save!  
      rescue Exception => e
        #log the exception
      end
    end
    return true #TODO Remove this add proper condition for this.
  end

  def self.calculate_member_maintainence(member)
    
  end

  def self.get_monthly_maintainence(for_month)
    maintainence = MonthlyMaintainence.find(:all, :conditions => ["month = ?", for_month])
  end
end
