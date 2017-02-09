class Manage::BusListsController < Manage::ApplicationController
  before_action :set_bus_list, only: [:show, :edit, :update, :destroy, :toggle_bus_captain, :send_update_email]

  respond_to :html

  def index
    @bus_lists = BusList.all
    respond_with(:manage, @bus_lists)
  end

  def show
    respond_with(:manage, @bus_list)
  end

  def new
    @bus_list = BusList.new
    respond_with(:manage, @bus_list)
  end

  def edit
  end

  def create
    @bus_list = BusList.new(bus_list_params)
    @bus_list.save
    respond_with(:manage, @bus_list)
  end

  def update
    @bus_list.update_attributes(bus_list_params)
    respond_with(:manage, @bus_list)
  end

  def destroy
    School.where(bus_list_id: @bus_list.id).each do |school|
      school.questionnaires.where(riding_bus: true).map { |q| q.update_attribute(:riding_bus, false) }
      school.update_attribute(:bus_list_id, nil)
    end
    @bus_list.destroy
    respond_with(:manage, @bus_list)
  end

  def toggle_bus_captain
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    is_bus_captain = params[:bus_captain] == "1"
    @questionnaire.update_attribute(:is_bus_captain, is_bus_captain)
    if @questionnaire.reload.is_bus_captain
      Mailer.delay.bus_captain_confirmation_email(@bus_list.id, @questionnaire.user.id)
    end
    redirect_to [:manage, @bus_list]
  end

  def send_update_email
    @bus_list.passengers.each do |passenger|
      Mailer.delay.bus_list_update_email(passenger.id)
    end
    redirect_to [:manage, @bus_list]
  end

  private

  def bus_list_params
    params.require(:bus_list).permit(
      :name, :capacity, :notes, :needs_bus_captain
    )
  end

  def set_bus_list
    @bus_list = BusList.find(params[:id])
  end
end
