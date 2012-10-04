class HomeController < ApplicationController
  
  def index
    #check current position in db 
    #TODO this need to be moved somewhere else
    month = MonthwisePosition.check_monthwise_position
    #binding.pry
    month = MonthwisePosition.get_curret_maintainence
    #binding.pry
    @monthly = MonthlyMaintainence.get_monthly_maintainence(month)
    #binding.pry
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end
end

