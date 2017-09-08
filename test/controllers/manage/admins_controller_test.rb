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
      post :datatable, format: :json, params: { "columns[0][data]" => "" }
      assert_response 401
    end

    should "not allow access to manage_admins#show" do
      get :show, params: { id: @user }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_admins#new" do
      get :new, params: { id: @user }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_admins#edit" do
      get :edit, params: { id: @user }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_admins#create" do
      post :create, params: { user: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_admins#update" do
      patch :update, params: { id: @user, user: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_admins#destroy" do
      patch :destroy, params: { id: @user }
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
      post :datatable, format: :json, params: { "columns[0][data]" => "" }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_admins#new" do
      get :new, params: { id: @user }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_admins#show" do
      get :show, params: { id: @user }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_admins#edit" do
      get :edit, params: { id: @user }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_admins#create" do
      post :create, params: { user: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_admins#update" do
      patch :update, params: { id: @user, user: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_admins#destroy" do
      patch :destroy, params: { id: @user }
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

    should "allow access to manage_admins#index" do
      get :index
      assert_response :success
    end

    should "allow access to manage_admins datatables api" do
      post :datatable, format: :json, params: { "columns[0][data]" => "" }
      assert_response :success
    end

    should "allow access to manage_admins#show" do
      get :show, params: { id: @user }
      assert_response :success
    end

    should "not allow access to manage_admins#new" do
      get :new
      assert_response :redirect
      assert_redirected_to manage_admins_path
    end

    should "not allow access to manage_admins#edit" do
      get :edit, params: { id: @user }
      assert_response :redirect
      assert_redirected_to manage_admins_path
    end

    should "not allow access to manage_admins#create" do
      post :create, params: { user: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to manage_admins_path
    end

    should "not allow access to manage_admins#update" do
      patch :update, params: { id: @user, user: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to manage_admins_path
    end

    should "not allow access to manage_admins#destroy" do
      patch :destroy, params: { id: @user }
      assert_response :redirect
      assert_redirected_to manage_admins_path
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
      post :create, params: { user: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to manage_admins_path
      assert assigns(:user).admin, "new user should be an admin"
    end

    should "create a new limited access admin" do
      post :create, params: { user: { email: "test@example.com", admin_limited_access: true } }
      assert_response :redirect
      assert_redirected_to manage_admins_path
      assert assigns(:user).admin, "new user should be an admin"
      assert assigns(:user).admin_limited_access, "new user should be a limited access admin"
    end

    should "not create an admin with duplicate emails" do
      create(:user, email: "existing@example.com")
      assert_difference('User.count', 0) do
        post :create, params: { user: { email: "existing@example.com" } }
      end
    end

    should "not allow access to manage_admins#new" do
      get :new, params: { id: @user }
      assert_response :success
    end

    should "allow access to manage_admins#show" do
      get :show, params: { id: @user }
      assert_response :success
    end

    should "allow access to manage_admins#edit" do
      get :edit, params: { id: @user }
      assert_response :success
    end

    should "update user" do
      patch :update, params: { id: @user, user: { email: "test@example.coma" } }
      assert_redirected_to manage_admins_path
    end

    should "destroy user" do
      assert_difference('User.count', -1) do
        patch :destroy, params: { id: @user }
      end
      assert_redirected_to manage_admins_path
    end
  end
end
