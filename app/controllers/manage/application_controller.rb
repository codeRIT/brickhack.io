class Manage::ApplicationController < ApplicationController
  before_filter :logged_in

  def logged_in
    authenticate_user!
    return redirect_to root_path unless current_user.try(:admin?)
    return redirect_to url_for(controller: controller_name, action: :index) if current_user.admin_limited_access && ["edit", "update", "new", "create", "destroy", "convert_to_admin", "deliver"].include?(action_name)
  end
end
