class HomeController < ApplicationController
  
  def index
    @monthly = MonthlyMaintainence.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end
end
