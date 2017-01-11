class BusListsController < ApplicationController
  before_action :logged_in
  before_action :check_user_has_questionnaire
  before_action :find_questionnaire
  before_action :find_bus_list
  before_action :require_bus_captian

  def logged_in
    authenticate_user!
  end

  # GET /bus_list
  def show
  end

  private

  def find_questionnaire
    @questionnaire = current_user.questionnaire
    redirect_to root_path unless @questionnaire
  end

  def find_bus_list
    @bus_list = @questionnaire.bus_list
    redirect_to root_path unless @bus_list
  end

  def check_user_has_questionnaire
    redirect_to root_path if current_user.questionnaire.nil?
  end

  def require_bus_captian
    redirect_to root_path unless @questionnaire.is_bus_captain?
  end
end
