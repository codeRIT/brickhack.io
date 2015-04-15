class BusListsController < ApplicationController
  before_filter :logged_in
  before_filter :check_user_has_questionnaire
  before_filter :find_questionnaire
  before_filter :find_bus_list
  before_filter :require_bus_captian

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
    if current_user.questionnaire.nil?
      redirect_to root_path
    end
  end

  def require_bus_captian
    unless @questionnaire.is_bus_captain?
      redirect_to root_path
    end
  end

end
