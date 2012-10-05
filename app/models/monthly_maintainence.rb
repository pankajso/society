class MonthlyMaintainence < ActiveRecord::Base
  attr_accessible :comment, :month, :name, :refnum, :total_due

  def self.generate_maintainence(for_month)
    retval = self.calculate_maintainence(for_month)
    return retval
  end

  def self.calculate_maintainence(for_month)
    prev_maintainence = MonthlyMaintainence.find(:all, :conditions => ["month = ?", for_month - 1.month])
    retval = false
    return if prev_maintainence.empty?
    members = Member.all
    for member in members
      prev_amount_due = MonthlyMaintainence.find(:all, :conditions => ["month = ? and refnum = ?", for_month - 1.month , member.refnum] ).first
      #TODO Calculate the Inwards for the same member from the previous months inwards 
      #TODO Also consider the adjustments, extra charges for this month if any
      #TODO Also if member had paid his dues in advance then also display / add the comments => need to figure out how this will be done  
      if !prev_amount_due.nil? then
        new_amount_due = prev_amount_due.total_due + member.Rule.amount
      
        begin
          record = MonthlyMaintainence.new(:refnum => member.refnum, :name => member.name, :month => for_month, :total_due => new_amount_due)
          record.save!  
          retval = true
        rescue Exception => e
          retval = fales
          #log the exception
        end
      end
    end
    return retval #TODO Remove this add proper condition for this.
  end

  def self.calculate_member_maintainence(member)
    
  end

  def self.get_monthly_maintainence(for_month)
    maintainence = MonthlyMaintainence.find(:all, :conditions => ["month = ?", for_month])
  end

end
