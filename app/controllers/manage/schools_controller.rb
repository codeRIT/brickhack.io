class Manage::SchoolsController < Manage::ApplicationController
  before_action :find_school, only: [:show, :edit, :update, :destroy, :merge, :perform_merge]

  respond_to :html

  def index
  end

  def datatable
    render json: SchoolDatatable.new(view_context)
  end

  def show
    respond_with(:manage, @school)
  end

  def new
    @school = ::School.new
    respond_with(:manage, @school)
  end

  def edit
  end

  def create
    @school = ::School.new(school_params)
    @school.save
    respond_with(:manage, @school, location: manage_schools_path)
  end

  def update
    @school.update_attributes(school_params)
    respond_with(:manage, @school, location: manage_schools_path)
  end

  def destroy
    @school.destroy
    respond_with(:manage, @school, location: manage_schools_path)
  end

  def merge
  end

  def perform_merge
    new_school_name = params[:school][:id]
    if new_school_name.blank?
      flash[:notice] = "Error: Must include the new school to merge into!"
      render :merge
      return
    end

    new_school = School.where(name: new_school_name).first
    if new_school.blank?
      flash[:notice] = "Error: School doesn't exist: #{new_school_name}"
      render :merge
      return
    end

    Questionnaire.where(school_id: @school.id).each do |q|
      q.update_attribute(:school_id, new_school.id)
    end

    SchoolNameDuplicate.create(name: @school.name, school_id: new_school.id)

    @school.reload

    if @school.questionnaire_count < 1
      @school.destroy
    else
      flash[:notice] = "*** Old school NOT deleted: #{@school.questionnaire_count} questionnaires still associated!\n"
    end

    redirect_to manage_schools_path(new_school)
  end

  private

  def school_params
    params.require(:school).permit(
      :name, :address, :city, :state, :bus_list_id
    )
  end

  def find_school
    @school = ::School.find(params[:id])
  end
end
