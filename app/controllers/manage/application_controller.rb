class Manage::ApplicationController < ApplicationController
  before_filter :logged_in

  def logged_in
    authenticate_user!
    return redirect_to root_path unless current_user.try(:admin?)
    return redirect_to url_for(controller: controller_name, action: :index) if current_user.admin_read_only && ["edit", "update", "new", "create", "destroy"].include?(action_name)
  end

  def index
    redirect_to manage_dashboard_index_path
  end
end
