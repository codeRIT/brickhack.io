class HomeController < ApplicationController
  def index
    render layout: "blank"
  end

  def comingsoon
    render layout: "blank"
  end

  def event
    render layout: "dayof"
  end

  def design_category
    render layout: "blank"
  end
end
