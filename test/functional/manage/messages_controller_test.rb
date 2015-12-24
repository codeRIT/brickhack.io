require 'test_helper'

class Manage::MessagesControllerTest < ActionController::TestCase

  before do
    ActionMailer::Base.deliveries = []
    Sidekiq::Extensions::DelayedMailer.jobs.clear
    Sidekiq::Worker.clear_all
  end

  setup do
    @message = create(:message)
  end

  context "while not authenticated" do
    should "redirect to sign in page on manage_messages#index" do
      get :index
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_messages datatables api" do
      post :datatable, format: :json
      assert_response 401
    end

    should "not allow access to manage_messages#new" do
      get :new
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_messages#show" do
      get :show, id: @message
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_messages#edit" do
      get :edit, id: @message
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_messages#create" do
      post :create, message: { email: "test@example.com" }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_messages#update" do
      put :update, id: @message, message: { email: "test@example.com" }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_messages#destroy" do
      put :destroy, id: @message
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not deliver message" do
      put :deliver, id: @message
      assert_equal 0, BulkMessageWorker.jobs.size, "should not trigger messages worker"
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end
  end

  context "while authenticated as a user" do
    setup do
      @user = create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
    end

    should "not allow access to manage_messages#index" do
      get :index
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_messages datatables api" do
      post :datatable, format: :json
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_messages#new" do
      get :new
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_messages#show" do
      get :show, id: @message
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_messages#edit" do
      get :edit, id: @message
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_messages#create" do
      post :create, message: { email: "test@example.com" }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_messages#update" do
      put :update, id: @message, message: { email: "test@example.com" }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_messages#destroy" do
      put :destroy, id: @message
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not deliver message" do
      put :deliver, id: @message
      assert_equal 0, BulkMessageWorker.jobs.size, "should not trigger messages worker"
      assert_response :redirect
      assert_redirected_to root_path
    end
  end

  context "while authenticated as a limited access admin" do
    setup do
      @user = create(:limited_access_admin)
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @user
    end

    should "allow access to manage_messages#index" do
      get :index
      assert_response :success
    end

    should "allow access to manage_messages datatables api" do
      post :datatable, format: :json
      assert_response :success
    end

    should "allow access to manage_messages#show" do
      get :show, id: @message
      assert_response :success
    end

    should "not allow access to manage_messages#new" do
      get :new
      assert_response :redirect
      assert_redirected_to manage_messages_path
    end

    should "not allow access to manage_messages#edit" do
      get :edit, id: @message
      assert_response :redirect
      assert_redirected_to manage_messages_path
    end

    should "not allow access to manage_messages#create" do
      post :create, message: { email: "test@example.com" }
      assert_response :redirect
      assert_redirected_to manage_messages_path
    end

    should "not allow access to manage_messages#update" do
      put :update, id: @message, message: { email: "test@example.com" }
      assert_response :redirect
      assert_redirected_to manage_messages_path
    end

    should "not allow access to manage_messages#destroy" do
      put :destroy, id: @message
      assert_response :redirect
      assert_redirected_to manage_messages_path
    end

    should "not deliver message" do
      put :deliver, id: @message
      assert_equal 0, BulkMessageWorker.jobs.size, "should not trigger messages worker"
      assert_response :redirect
      assert_redirected_to manage_messages_path
    end
  end

  context "while authenticated as an admin" do
    setup do
      @user = create(:admin)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
    end

    should "allow access to manage_messages#index" do
      get :index
      assert_response :success
    end

    should "allow access to manage_messages#new" do
      get :new
      assert_response :success
    end

    should "create a new message" do
      post :create, message: { name: "New Message Name", subject: "Subject", recipients: ["abc"], body: "Example" }
      assert_response :redirect
      assert_redirected_to manage_message_path(assigns(:message))
    end

    should "allow access to manage_messages#show" do
      get :show, id: @message
      assert_response :success
    end

    should "allow access to manage_messages#edit" do
      get :edit, id: @message
      assert_response :success
    end

    should "update message" do
      put :update, id: @message, message: { name: "New Message Name", subject: "Subject", recipients: ["abc"], body: "Example" }
      assert_redirected_to manage_message_path(assigns(:message))
    end

    should "deliver message" do
      assert_equal 0, BulkMessageWorker.jobs.size, "worker should not be running prior to delivery"
      put :deliver, id: @message
      assert_equal 1, BulkMessageWorker.jobs.size, "should trigger messages worker"
      assert_match /queued/, flash[:notice]
      assert_redirected_to manage_message_path(assigns(:message))
    end

    should "not allow multiple deliveries" do
      put :deliver, id: @message
      assert_match /queued/, flash[:notice]
      put :deliver, id: @message
      assert_match /cannot/, flash[:notice]
    end

    should "not be able to modify message after delivery" do
      @message.update_attribute(:delivered_at, 1.minute.ago)
      old_message_name = @message.name
      put :update, id: @message, message: { name: "New Message Name" }
      assert_match /can no longer/, flash[:notice]
      assert_equal old_message_name, @message.reload.name
    end

    should "destroy message" do
      assert_difference('Message.count', -1) do
        put :destroy, id: @message
      end
      assert_redirected_to manage_messages_path
    end
  end
end
