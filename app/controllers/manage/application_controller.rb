class Manage::ApplicationController < ApplicationController
  before_filter :logged_in

  def logged_in
    authenticate_user!
    return redirect_to root_path unless current_user.try(:admin?)
  end

  def index
    redirect_to manage_dashboard_index_path
  end
end
