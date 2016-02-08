class Manage::SchoolsController < Manage::ApplicationController
  before_filter :find_school, only: [:show, :edit, :update, :destroy]

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
    parameters = params[:school]
    @school = ::School.new(parameters)
    @school.save
    respond_with(:manage, @school, location: manage_schools_path)
  end

  def update
    @school.update_attributes(params[:school])
    respond_with(:manage, @school, location: manage_schools_path)
  end

  def destroy
    @school.destroy
    respond_with(:manage, @school, location: manage_schools_path)
  end

  private

  def find_school
    @school = ::School.find(params[:id])
  end
end
