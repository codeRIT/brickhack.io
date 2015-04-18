class HomeController < ApplicationController
  def index
    render :layout => "blank"
  end

  def event
    render :layout => "dayof"
  end
end
