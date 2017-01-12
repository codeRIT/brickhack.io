class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def mlh
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      session["devise.provider_data"] = request.env["omniauth.auth"]
      set_flash_message(:notice, :success, kind: "My MLH") if is_navigational_format?
      @user.queue_reminder_email
    else
      redirect_to new_user_registration_url
    end
  end

  def failure
    flash[:notice] = "External authentication failed - try again?"
    redirect_to new_user_session_url
  end
end
