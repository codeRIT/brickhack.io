class RsvpsController < ApplicationController
  before_filter :logged_in
  before_filter :check_user_has_questionnaire
  before_filter :find_questionnaire
  before_filter :require_accepted_questionnaire

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
    unless @questionnaire.save(without_protection: true)
      flash[:notice] = "There was an error submitting your response, please check over your application and try again. Did you accept the BrickHack Agreement?"
    end
    redirect_to rsvp_path
  end

  # GET /rsvp/deny
  def deny
    @questionnaire.acc_status = "rsvp_denied"
    @questionnaire.acc_status_author_id = current_user.id
    @questionnaire.acc_status_date = Time.now
    unless @questionnaire.save(without_protection: true)
      flash[:notice] = "There was an error submitting your response, please check over your application and try again. Did you accept the BrickHack Agreement?"
    end
    redirect_to rsvp_path
  end

  # PUT /rsvp
  def update
    unless @questionnaire.update_attributes(params[:questionnaire].slice(:agreement_accepted))
      flash[:notice] = @questionnaire.errors.full_messages.join(", ")
      redirect_to rsvp_path
      return
    end

    unless ["rsvp_confirmed", "rsvp_denied"].include? params[:questionnaire][:acc_status]
      flash[:notice] = "Please select a RSVP status."
      redirect_to rsvp_path
      return
    end

    @questionnaire.acc_status = params[:questionnaire][:acc_status]
    @questionnaire.acc_status_author_id = current_user.id
    @questionnaire.acc_status_date = Time.now
    @questionnaire.riding_bus = params[:questionnaire][:riding_bus]
    if @questionnaire.riding_bus && @questionnaire.bus_list && @questionnaire.bus_list.full?
      flash[:notice] = "Sorry, your bus is full! You may need to arrange other plans for transportation."
      @questionnaire.riding_bus = false
    elsif !@questionnaire.can_ride_bus?
      @questionnaire.riding_bus = false
    end

    unless @questionnaire.save(without_protection: true)
      flash[:notice] = @questionnaire.errors.full_message.join(", ")
      redirect_to rsvp_path
      return
    end

    redirect_to rsvp_path
  end

  private

  def find_questionnaire
    @questionnaire = current_user.questionnaire
  end

  def check_user_has_questionnaire
    if current_user.questionnaire.nil?
      redirect_to root_path
    end
  end

  def require_accepted_questionnaire
    unless @questionnaire.can_rsvp?
      redirect_to root_path
    end
  end

end
