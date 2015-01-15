class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if current_user.admin?
      manage_root_path
    elsif current_user.questionnaire === nil
      new_questionnaire_path
    else
      @questionnaire = current_user.questionnaire
      questionnaire_path(current_user.questionnaire)
    end
  end
end
