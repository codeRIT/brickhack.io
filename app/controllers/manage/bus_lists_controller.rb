class Manage::BusListsController < Manage::ApplicationController
  before_filter :set_bus_list, only: [:show, :edit, :update, :destroy]

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
    @bus_list = BusList.new(params[:bus_list])
    @bus_list.save
    respond_with(:manage, @bus_list)
  end

  def update
    @bus_list.update_attributes(params[:bus_list])
    respond_with(:manage, @bus_list)
  end

  def destroy
    @bus_list.destroy
    respond_with(:manage, @bus_list)
  end

  private
    def set_bus_list
      @bus_list = BusList.find(params[:id])
    end
end
