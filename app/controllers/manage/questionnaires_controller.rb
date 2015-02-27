class Manage::QuestionnairesController < Manage::ApplicationController
  before_filter :set_questionnaire, only: [:show, :edit, :update, :destroy, :convert_to_admin, :update_acc_status]

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

  def update_acc_status
    new_status = params[:questionnaire][:acc_status]
    if new_status.blank?
      flash[:notice] = "No status provided"
      redirect_to(manage_questionnaire_path(@questionnaire))
    end

    @questionnaire.acc_status = new_status
    @questionnaire.acc_status_author_id = current_user.id
    @questionnaire.acc_status_date = Time.now

    unless @questionnaire.save(validate: false, without_protection: true)
      flash[:notice] = "Failed to update acceptance status"
    end
    redirect_to manage_questionnaire_path(@questionnaire)
  end

  def bulk_apply
    action = params[:bulk_action]
    ids = params[:bulk_ids]
    if action.blank? || ids.blank?
      render nothing: true, status: 400
      return
    end
    Questionnaire.find(ids).each do |q|
      q.acc_status = action
      q.acc_status_author_id = current_user.id
      q.acc_status_date = Time.now
      q.save(validate: false, without_protection: true)
    end
    render nothing: true, staus: 200
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
