class Manage::QuestionnairesController < Manage::ApplicationController
  before_filter :set_questionnaire, only: [:show, :edit, :update, :destroy, :convert_to_admin]

  respond_to :html

  def index
    respond_to do |format|
      format.html
      format.json { render json: QuestionnaireDatatable.new(view_context) }
    end
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
    email = params[:questionnaire].delete(:email)
    params[:questionnaire] = convert_school_name_to_id params[:questionnaire]
    @questionnaire = ::Questionnaire.new(params[:questionnaire])
    if @questionnaire.save
      user = User.new(email: email, password: Devise.friendly_token.first(10))
      if user.save
        @questionnaire.user = user
        @questionnaire.save
      else
        return redirect_to edit_manage_questionnaire_path(@questionnaire)
      end
    end
    respond_with(:manage, @questionnaire)
  end

  def update
    email = params[:questionnaire].delete(:email)
    if email.present?
      @questionnaire.user.update_attributes(email: email)
    end
    params[:questionnaire] = convert_school_name_to_id params[:questionnaire]
    @questionnaire.update_attributes(params[:questionnaire])
    respond_with(:manage, @questionnaire)
  end

  def convert_to_admin
    user = @questionnaire.user
    @questionnaire.destroy
    user.update_attributes({ admin: true, admin_read_only: true }, without_protection: true)
    redirect_to edit_manage_admin_path(user)
  end

  def destroy
    user = @questionnaire.user
    @questionnaire.destroy
    user.destroy if user.present?
    respond_with(:manage, @questionnaire)
  end

  private

  def set_questionnaire
    @questionnaire = ::Questionnaire.find(params[:id])
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
