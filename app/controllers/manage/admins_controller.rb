class Manage::AdminsController < Manage::ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
  end

  def datatable
    render json: AdminDatatable.new(view_context)
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
    @user = ::User.new(user_params.merge(password: Devise.friendly_token.first(10)))
    if @user.save
      @user.update_attribute(:admin, true)
      @user.send_reset_password_instructions
    end
    respond_with(:manage, @user, location: manage_admins_path)
  end

  def update
    @user.update_attributes(user_params)
    respond_with(:manage, @user, location: manage_admins_path)
  end

  def destroy
    @user.destroy
    respond_with(:manage, @user, location: manage_admins_path)
  end

  private

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :remember_me, :admin_limited_access
    )
  end

  def find_user
    @user = ::User.find(params[:id])
  end
end
