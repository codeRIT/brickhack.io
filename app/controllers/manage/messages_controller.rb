class Manage::MessagesController < Manage::ApplicationController
  before_filter :set_message, only: [:show, :edit, :update, :destroy, :deliver]
  before_filter :check_message_access, only: [:edit, :update, :destroy]

  respond_to :html

  def index
  end

  def datatable
    render json: MessageDatatable.new(view_context)
  end

  def show
    respond_with(:manage, @message)
  end

  def new
    @message = Message.new
    respond_with(:manage, @message)
  end

  def edit
  end

  def create
    @message = Message.new(params[:message])
    @message.save
    respond_with(:manage, @message)
  end

  def update
    @message.update_attributes(params[:message])
    respond_with(:manage, @message)
  end

  def destroy
    @message.destroy
    respond_with(:manage, @message)
  end

  def deliver
    if @message.status != "drafted"
      flash[:notice] = "Message cannot be re-delivered"
      return redirect_to manage_messages_path
    end
    @message.update_attribute(:queued_at, Time.now)
    BulkMessageWorker.perform_async(@message.id)
    flash[:notice] = "Message queued for delivery"
    redirect_to manage_message_path(@message)
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def check_message_access
      unless @message.can_edit?
        flash[:notice] = "Message can no longer be modified"
        return redirect_to manage_message_path(@message)
      end
    end
end
