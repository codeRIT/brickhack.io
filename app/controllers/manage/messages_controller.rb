class Manage::MessagesController < Manage::ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy, :deliver, :preview, :duplicate]
  before_action :check_message_access, only: [:edit, :update, :destroy]

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
    @message = Message.new(message_params)
    @message.save
    respond_with(:manage, @message)
  end

  def update
    @message.update_attributes(message_params)
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

  def preview
    email = Mailer.bulk_message_email(@message.id, current_user.id)
    render html: email.body.raw_source.html_safe
  end

  def duplicate
    new_message = @message.dup
    new_message.update_attributes(
      delivered_at: nil,
      started_at: nil,
      queued_at: nil,
      name: "Copy of #{@message.name}"
    )
    new_message.save
    redirect_to edit_manage_message_path(new_message.reload)
  end

  private

  def message_params
    params.require(:message).permit(
      :name, :subject, :template, :body, recipients: []
    )
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def check_message_access
    return if @message.can_edit?

    flash[:notice] = "Message can no longer be modified"
    redirect_to manage_message_path(@message)
  end
end
