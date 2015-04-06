class Manage::DashboardController < Manage::ApplicationController
  include Chartkick::Remote
  chartkick_remote

  def index
  end

  def map_data
    @schools = School.where("questionnaire_count", 1..Float::INFINITY).select([:city, :state, :questionnaire_count])
  end
end
