class QuestionnairesController < ApplicationController
  include QuestionnairesControllable

  before_action :logged_in
  before_action :find_questionnaire, only: [:show, :update, :edit, :destroy]

  def logged_in
    authenticate_user!
  end

  # GET /apply
  # GET /apply.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @questionnaire }
    end
  end

  # GET /apply/new
  # GET /apply/new.json
  def new
    if current_user.questionnaire.present?
      return redirect_to questionnaires_path
    end
    @questionnaire = Questionnaire.new

    if session["devise.provider_data"] && session["devise.provider_data"]["info"]
      @questionnaire.tap do |q|
        q.first_name = session["devise.provider_data"]["info"]["first_name"]
        q.last_name = session["devise.provider_data"]["info"]["last_name"]
        q.phone = session["devise.provider_data"]["info"]["phone_number"]
        q.level_of_study = session["devise.provider_data"]["info"]["level_of_study"]
        q.major = session["devise.provider_data"]["info"]["major"]
        q.date_of_birth = session["devise.provider_data"]["info"]["date_of_birth"]
        q.shirt_size = session["devise.provider_data"]["info"]["shirt_size"]
        q.dietary_restrictions = session["devise.provider_data"]["info"]["dietary_restrictions"]
        q.special_needs = session["devise.provider_data"]["info"]["special_needs"]
        q.gender = session["devise.provider_data"]["info"]["gender"]

        school = School.where(name: session["devise.provider_data"]["info"]["school"]["name"]).first_or_create do |s|
          s.name = session["devise.provider_data"]["info"]["school"]["name"]
        end
        q.school_id = school.id
      end
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @questionnaire }
    end
  end

  # GET /apply/edit
  def edit
  end

  # POST /apply
  # POST /apply.json
  def create
    if current_user.questionnaire.present?
      return redirect_to questionnaires_path, notice: 'Application already exists.'
    end
    @questionnaire = Questionnaire.new(convert_school_name_to_id(questionnaire_params))

    respond_to do |format|
      if @questionnaire.save
        current_user.questionnaire = @questionnaire
        @questionnaire.update_attribute(:acc_status, default_acc_status)
        Mailer.delay.application_confirmation_email(@questionnaire.id)
        format.html { redirect_to questionnaires_path, notice: 'Application was successfully created.' }
        format.json { render json: @questionnaire, status: :created, location: @questionnaire }
      else
        format.html { render action: "new" }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /apply
  # PUT /apply.json
  def update
    update_params = questionnaire_params
    update_params = convert_school_name_to_id(update_params)

    respond_to do |format|
      if @questionnaire.update_attributes(update_params)
        format.html { redirect_to questionnaires_path, notice: 'Application was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apply
  # DELETE /apply.json
  def destroy
    @questionnaire.destroy

    respond_to do |format|
      format.html { redirect_to questionnaires_url }
      format.json { head :no_content }
    end
  end

  # GET /apply/schools
  def schools
    if params[:name].blank? || params[:name].length < 3
      head :bad_request
      return
    end
    schools = School.where('name LIKE ?', "%#{params[:name]}%").order(questionnaire_count: :desc).limit(20).select(:name).all
    render json: schools.map(&:name)
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
      :resume, :delete_resume
    )
  end

  def find_questionnaire
    unless current_user.questionnaire.present?
      return redirect_to new_questionnaires_path
    end
    @questionnaire = current_user.questionnaire
  end

  def default_acc_status
    return "late_waitlist" if Rails.configuration.hackathon['auto_late_waitlist']
    "pending"
  end
end
