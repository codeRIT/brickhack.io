class HomeController < ApplicationController
  def index
  end

  def event
    render :layout => "dayof"
  end
end
