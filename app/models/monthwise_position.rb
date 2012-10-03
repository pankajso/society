class MonthwisePosition < ActiveRecord::Base
  include AASM
  attr_accessible :month, :position

  # state machine
  aasm_column :position

  aasm_initial_state :generated

  aasm_state :generated
  aasm_state :draft
  aasm_state :approved
  aasm_state :reviewing
  aasm_state :closed
  
  aasm_event :draft do 
    transitions :to => :draft, :from => [:generated]
  end

  aasm_event :approved do
    transitions :to => :approve, :from => [:draft, :reviewing]
  end

  aasm_event :reviewing do
    transitions :to => :reviewing, :from => [:generate, :approve]
  end

  aasm_event :closed do
    transitions :to => :close, :from => [:approve]
  end

  def editable?
    closed? 
  end

  def self.check_monthwise_position()
    generated = MonthwisePosition.generated
    return if generated.empty?
    #ideally this should be always 1 generated.count
    begin
      for month in generated
        retval = MonthlyMaintainence.generate_maintainence(month.month)
        if retval then
          month.draft!
        end
      end
    rescue Exception => e
      #Add msg in log take some action
    end
    month.month
  end

  def self.get_curret_maintainence
    months = MonthwisePosition.draft
    if months.empty? then
      months = MonthwisePosition.approved
    end
    for month in months 
      return month.month
    end
  end
end
