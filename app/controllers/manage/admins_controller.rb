class Manage::AdminsController < Manage::ApplicationController
  before_filter :find_user, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    respond_to do |format|
      format.html
      format.json { render json: AdminDatatable.new(view_context) }
    end
  end

  def show
    respond_with(:manage, @user)
  end

  def new
    @user = ::User.new
    respond_with(:manage, @user)
  end

  def edit
  end

  def create
    parameters = params[:user]
    parameters.merge!(password: Devise.friendly_token.first(10))
    @user = ::User.new(parameters)
    if (@user.save)
      @user.update_attributes({ admin: true }, without_protection: true)
      @user.send_reset_password_instructions
    end
    respond_with(:manage, @user, location: manage_admins_path)
  end

  def update
    @user.update_attributes(params[:user])
    respond_with(:manage, @user, location: manage_admins_path)
  end

  def destroy
    @user.destroy
    respond_with(:manage, @user, location: manage_admins_path)
  end

  private

  def find_user
    @user = ::User.find(params[:id])
  end
end
