require 'state_machine'
class MonthwisePosition < ActiveRecord::Base
  attr_accessible :month, :position
  state_machine :position, :initial => :idle do
    event :generate do 
      transition [:idle, :generated] => :generated
    end
    event :generated do
      transition [:generated] => :approved
    end
    event :approved do
      transition [:approved] => :close
    end
    position :idle, :generate, :generated, :approved, :close
    
    #Update the postion of the month
    def self.update_position(month, position)
      @month_position = MonthwisePosition.find(:all, :conditions => ["month = ?", month]).first
      if @month_position.position.blank?
        @month_position.update_attribute(position, 'idle')
        @month_position.save
      end
      if position == 'generated'
        @month_position.generated!
      elsif position == 'approved'
        @month_position.approved!
      elsif position == 'close'
        @month_position.close!
      end
    end
end
