class RsvpsController < ApplicationController
  before_action :logged_in
  before_action :check_user_has_questionnaire
  before_action :find_questionnaire
  before_action :require_accepted_questionnaire

  def logged_in
    authenticate_user!
  end

  # GET /rsvp
  def show
  end

  # GET /rsvp/accept
  def accept
    @questionnaire.acc_status = "rsvp_confirmed"
    @questionnaire.acc_status_author_id = current_user.id
    @questionnaire.acc_status_date = Time.now
    if @questionnaire.save
      Mailer.delay.rsvp_confirmation_email(@questionnaire.id)
    else
      flash[:notice] = "There was an error submitting your response, please check over your application and try again. Did you accept the BrickHack Agreement?"
    end
    redirect_to rsvp_path
  end

  # GET /rsvp/deny
  def deny
    @questionnaire.acc_status = "rsvp_denied"
    @questionnaire.acc_status_author_id = current_user.id
    @questionnaire.acc_status_date = Time.now
    unless @questionnaire.save
      flash[:notice] = "There was an error submitting your response, please check over your application and try again. Did you accept the BrickHack Agreement?"
    end
    redirect_to rsvp_path
  end

  # PUT /rsvp
  def update
    unless @questionnaire.update_attributes(params.require(:questionnaire).permit(:agreement_accepted, :phone))
      flash[:notice] = @questionnaire.errors.full_messages.join(", ")
      redirect_to rsvp_path
      return
    end

    unless ["rsvp_confirmed", "rsvp_denied"].include? params[:questionnaire][:acc_status]
      flash[:notice] = "Please select a RSVP status."
      redirect_to rsvp_path
      return
    end

    @questionnaire.acc_status_date = Time.now if @questionnaire.acc_status != params[:questionnaire][:acc_status]
    @questionnaire.acc_status = params[:questionnaire][:acc_status]
    @questionnaire.acc_status_author_id = current_user.id
    if !@questionnaire.riding_bus && params[:questionnaire][:riding_bus] == "true" && @questionnaire.bus_list && @questionnaire.bus_list.full?
      flash[:notice] = "Sorry, your bus is full! You may need to arrange other plans for transportation."
      @questionnaire.riding_bus = false
      @questionnaire.bus_captain_interest = false
    elsif !@questionnaire.eligible_for_a_bus?
      @questionnaire.riding_bus = false
      @questionnaire.bus_captain_interest = false
    else
      @questionnaire.riding_bus = params[:questionnaire][:riding_bus]
      @questionnaire.bus_captain_interest = params[:questionnaire][:bus_captain_interest]
    end

    acc_status_changed = @questionnaire.acc_status_changed?

    unless @questionnaire.save
      flash[:notice] = @questionnaire.errors.full_message.join(", ")
      redirect_to rsvp_path
      return
    end

    Mailer.delay.rsvp_confirmation_email(@questionnaire.id) if acc_status_changed && @questionnaire.acc_status == "rsvp_confirmed"

    redirect_to rsvp_path
  end

  private

  def find_questionnaire
    @questionnaire = current_user.questionnaire
  end

  def check_user_has_questionnaire
    redirect_to new_questionnaires_path if current_user.questionnaire.nil?
  end

  def require_accepted_questionnaire
    return if @questionnaire.can_rsvp? || @questionnaire.checked_in?
    redirect_to new_questionnaires_path
  end
end
