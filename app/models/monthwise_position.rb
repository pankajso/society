class MonthwisePosition < ActiveRecord::Base
  include AASM
  attr_accessible :month, :position

  aasm :column => 'position' do
    state :generated, :initial => true
    state :approved
    state :reviewed
    state :closed

    event :close do
      transitions :from => :approved, :to => :closed
    end

    event :review do
      transitions :from => :approved, :to => :reviewd
    end

    event :approve do
      transitions :from => [:reviewd, :generated], :to => :approved
    end
  end

  
  #Update the position of the month
  def self.update_position(month, position)
    @month_position = MonthwisePosition.find(:all, :conditions => ["month = ?", month]).first
    if @month_position.position.blank?
      @month_position.update_attribute(position, 'generated')
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
