class Manage::QuestionnairesController < Manage::ApplicationController
  include QuestionnairesControllable

  before_action :set_questionnaire, only: [:show, :edit, :update, :destroy, :check_in, :convert_to_admin, :update_acc_status, :message_events, :invite_to_slack]

  respond_to :html

  def index
  end

  def datatable
    render json: QuestionnaireDatatable.new(view_context)
  end

  def show
    respond_with(:manage, @questionnaire)
  end

  def new
    @questionnaire = ::Questionnaire.new
    respond_with(:manage, @questionnaire)
  end

  def edit
  end

  def create
    create_params = questionnaire_params
    email = create_params.delete(:email)
    create_params = convert_school_name_to_id(create_params)
    @questionnaire = ::Questionnaire.new(create_params)
    if @questionnaire.valid?
      user = User.new(email: email, password: Devise.friendly_token.first(10))
      if user.save
        @questionnaire.user = user
        @questionnaire.save
      else
        flash[:notice] = user.errors.full_messages.join(", ")
        if user.errors.include?(:email)
          @questionnaire.errors.add(:email, user.errors[:email].join(", "))
        end
        return render 'new'
      end
    end
    respond_with(:manage, @questionnaire)
  end

  def update
    update_params = questionnaire_params
    email = update_params.delete(:email)
    @questionnaire.user.update_attributes(email: email) if email.present?
    update_params = convert_school_name_to_id(update_params)
    @questionnaire.update_attributes(update_params)
    respond_with(:manage, @questionnaire)
  end

  def check_in
    if params[:check_in] == "true"
      if params[:questionnaire]
        q_params = params.require(:questionnaire).permit(:agreement_accepted, :phone, :can_share_info, :email)
        email = q_params.delete(:email)
        @questionnaire.update_attributes(q_params)
        @questionnaire.user.update_attributes(email: email)
      end
      unless @questionnaire.valid?
        flash[:notice] = @questionnaire.errors.full_messages.join(", ")
        redirect_to manage_questionnaire_path @questionnaire
        return
      end
      @questionnaire.update_attribute(:checked_in_at, Time.now)
      @questionnaire.update_attribute(:checked_in_by_id, current_user.id)
      @questionnaire.invite_to_slack
      flash[:notice] = "Checked in #{@questionnaire.full_name}."
    elsif params[:check_in] == "false"
      @questionnaire.update_attribute(:checked_in_at, nil)
      @questionnaire.update_attribute(:checked_in_by_id, current_user.id)
      flash[:notice] = "#{@questionnaire.full_name} no longer checked in."
    else
      flash[:notice] = "No check-in action provided!"
      redirect_to manage_questionnaire_path @questionnaire
      return
    end
    redirect_to manage_questionnaires_path
  end

  def convert_to_admin
    user = @questionnaire.user
    @questionnaire.destroy
    user.update_attributes(admin: true, admin_limited_access: true)
    redirect_to edit_manage_admin_path(user)
  end

  def destroy
    user = @questionnaire.user
    @questionnaire.destroy
    user.destroy if user.present?
    respond_with(:manage, @questionnaire)
  end

  def update_acc_status
    new_status = params[:questionnaire][:acc_status]
    if new_status.blank?
      flash[:notice] = "No status provided"
      redirect_to(manage_questionnaire_path(@questionnaire))
      return
    end

    @questionnaire.acc_status = new_status
    @questionnaire.acc_status_author_id = current_user.id
    @questionnaire.acc_status_date = Time.now

    unless @questionnaire.save(validate: false)
      flash[:notice] = "Failed to update acceptance status"
    end

    process_acc_status_notifications(@questionnaire, new_status)

    redirect_to manage_questionnaire_path(@questionnaire)
  end

  def bulk_apply
    action = params[:bulk_action]
    ids = params[:bulk_ids]
    if action.blank? || ids.blank?
      head :bad_request
      return
    end
    Questionnaire.find(ids).each do |q|
      q.acc_status = action
      q.acc_status_author_id = current_user.id
      q.acc_status_date = Time.now
      q.save(validate: false) && process_acc_status_notifications(q, action)
    end
    head :ok
  end

  def invite_to_slack
    @questionnaire.invite_to_slack
    flash[:notice] = 'Slack invite has been queued for delivery'
    redirect_to manage_questionnaire_path @questionnaire
  end

  def message_events
    render json: @questionnaire.message_events
  end

  private

  def questionnaire_params
    params.require(:questionnaire).permit(
      :email, :experience, :first_name, :last_name, :gender,
      :date_of_birth, :interest, :school_id, :school_name, :major, :level_of_study,
      :shirt_size, :dietary_restrictions, :special_needs, :international,
      :portfolio_url, :vcs_url, :agreement_accepted, :bus_captain_interest,
      :riding_bus, :phone, :can_share_info, :code_of_conduct_accepted,
      :travel_not_from_school, :travel_location, :data_sharing_accepted,
      :resume, :delete_resume, :is_bus_captain
    )
  end

  def set_questionnaire
    @questionnaire = ::Questionnaire.find(params[:id])
  end

  def process_acc_status_notifications(questionnaire, new_status)
    Mailer.delay.accepted_email(questionnaire.id) if new_status == "accepted"
    Mailer.delay.rsvp_confirmation_email(questionnaire.id) if new_status == "rsvp_confirmed"
    Mailer.delay.denied_email(questionnaire.id) if new_status == "denied"

    questionnaire.invite_to_slack if ENV['INVITE_TO_SLACK_WHEN_ACCEPTED'] == 'true' && ['accepted', 'rsvp_confirmed'].include?(new_status)
  end
end
