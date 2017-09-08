class HomeController < ApplicationController
  def index
    render layout: "blank"
  end

  def comingsoon
    render layout: "blank"
  end

  def design_category
    render layout: "blank"
  end

  def apilist
    render layout: "api"
  end
end
