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

  def apilist
    render layout: "api"
  end