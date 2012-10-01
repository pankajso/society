class HomeController < ApplicationController
  
  def index
    @monthly = MonthlyMaintainence.get_monthly_maintainence()

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end
end

