require 'test_helper'

class Manage::AdminsControllerTest < ActionController::TestCase

  setup do
    @user = create(:user)
  end

  context "while not authenticated" do
    should "redirect to sign in page on manage_admins#index" do
      get :index
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_admins datatables api" do
      get :index, format: :json
      assert_response 401
    end

    should "not allow access to manage_admins#show" do
      get :show, id: @user
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_admins#edit" do
      get :edit, id: @user
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_admins#create" do
      post :create, user: { email: "test@example.com" }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_admins#update" do
      put :update, id: @user, user: { email: "test@example.com" }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end
  end

  context "while authenticated as a user" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
    end

    should "not allow access to manage_admins#index" do
      get :index
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_admins datatables api" do
      get :index, format: :json
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_admins#show" do
      get :show, id: @user
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_admins#edit" do
      get :edit, id: @user
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_admins#create" do
      post :create, user: { email: "test@example.com" }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_admins#update" do
      put :update, id: @user, user: { email: "test@example.com" }
      assert_response :redirect
      assert_redirected_to root_path
    end
  end

  context "while authenticated as an admin" do
    setup do
      @user = create(:admin)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
    end

    should "allow access to manage_admins#index" do
      get :index
      assert_response :success
    end

    should "create a new admin" do
      post :create, user: { email: "test@example.com" }
      assert_response :redirect
      assert_redirected_to manage_admins_path
      assert assigns(:user).admin, "new user should be an admin"
    end

    should "create a new read-only admin" do
      post :create, user: { email: "test@example.com", admin_read_only: true }
      assert_response :redirect
      assert_redirected_to manage_admins_path
      assert assigns(:user).admin, "new user should be an admin"
      assert assigns(:user).admin_read_only, "new user should be a read-only admin"
    end

    should "allow access to manage_admins#show" do
      get :show, id: @user
      assert_response :success
    end

    should "allow access to manage_admins#edit" do
      get :edit, id: @user
      assert_response :success
    end

    should "update user" do
      put :update, id: @user, user: { email: "test@example.coma" }
      assert_redirected_to manage_admins_path
    end
  end
end
