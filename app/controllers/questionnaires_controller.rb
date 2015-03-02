class QuestionnairesController < ApplicationController
  before_filter :logged_in
  before_filter :restrict_questionnaire_access
  before_filter :check_user_has_questionnaire, only: [:show, :edit, :update, :destroy]

  def logged_in
    authenticate_user!
  end

  # GET /apply
  def index
    redirect_to new_questionnaire_path
  end

  # GET /apply/1
  # GET /apply/1.json
  def show
    @questionnaire = Questionnaire.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @questionnaire }
    end
  end

  # GET /apply/new
  # GET /apply/new.json
  def new
    if current_user.questionnaire.present?
      return redirect_to questionnaire_path(current_user.questionnaire)
    end
    @questionnaire = Questionnaire.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @questionnaire }
    end
  end

  # GET /apply/1/edit
  def edit
    @questionnaire = Questionnaire.find(params[:id])
  end

  # POST /apply
  # POST /apply.json
  def create
    if current_user.questionnaire.present?
      return redirect_to current_user.questionnaire, notice: 'Application already exists.'
    end
    params[:questionnaire] = convert_school_name_to_id params[:questionnaire]
    @questionnaire = Questionnaire.new(params[:questionnaire])

    respond_to do |format|
      if @questionnaire.save
        current_user.questionnaire = @questionnaire
        @questionnaire.update_attribute(:acc_status, "late_waitlist")
        Mailer.delay.application_confirmation_email(@questionnaire.id)
        format.html { redirect_to @questionnaire, notice: 'Application was successfully created.' }
        format.json { render json: @questionnaire, status: :created, location: @questionnaire }
      else
        format.html { render action: "new" }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /apply/1
  # PUT /apply/1.json
  def update
    params[:questionnaire] = convert_school_name_to_id params[:questionnaire]
    @questionnaire = Questionnaire.find(params[:id])

    respond_to do |format|
      if @questionnaire.update_attributes(params[:questionnaire])
        format.html { redirect_to @questionnaire, notice: 'Application was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apply/1
  # DELETE /apply/1.json
  def destroy
    @questionnaire = Questionnaire.find(params[:id])
    @questionnaire.destroy

    respond_to do |format|
      format.html { redirect_to questionnaires_url }
      format.json { head :no_content }
    end
  end

  # GET /apply/schools
  def schools
    if params[:name].blank? || params[:name].length < 3
      head 400
      return
    end
    schools = School.where('name LIKE ?', "%#{params[:name]}%").limit(20).select(:name).all
    render json: schools.map(&:name)
  end

  private

  def restrict_questionnaire_access
    if params[:id].present? && current_user.questionnaire.to_param != params[:id]
      return redirect_to new_questionnaire_path unless current_user.questionnaire.present?
      return redirect_to questionnaire_path(current_user.questionnaire)
    end
  end

  def check_user_has_questionnaire
    if current_user.questionnaire.nil?
      redirect_to new_questionnaire_path
    end
  end

  def convert_school_name_to_id(questionnaire)
    if questionnaire[:school_name]
      school = School.where(name: questionnaire[:school_name]).first
      if school.blank?
        school = School.create(name: questionnaire[:school_name])
      end
      questionnaire[:school_id] = school.id
      questionnaire.delete :school_name
    end
    questionnaire
  end
end
