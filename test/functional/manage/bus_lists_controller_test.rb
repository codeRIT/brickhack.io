require 'test_helper'

class Manage::BusListsControllerTest < ActionController::TestCase

  setup do
    @bus_list = create(:bus_list)
  end

  context "while not authenticated" do
    should "redirect to sign in page on manage_bus_lists#index" do
      get :index
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_bus_lists datatables api" do
      get :index, format: :json
      assert_response 401
    end

    should "not allow access to manage_bus_lists#show" do
      get :show, id: @bus_list
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_bus_lists#edit" do
      get :edit, id: @bus_list
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_bus_lists#create" do
      post :create, bus_list: { email: "test@example.com" }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_bus_lists#update" do
      put :update, id: @bus_list, bus_list: { email: "test@example.com" }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_bus_lists#destroy" do
      put :destroy, id: @bus_list
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

    should "not allow access to manage_bus_lists#index" do
      get :index
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_bus_lists datatables api" do
      get :index, format: :json
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_bus_lists#show" do
      get :show, id: @bus_list
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_bus_lists#edit" do
      get :edit, id: @bus_list
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_bus_lists#create" do
      post :create, bus_list: { email: "test@example.com" }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_bus_lists#update" do
      put :update, id: @bus_list, bus_list: { email: "test@example.com" }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_bus_lists#destroy" do
      put :destroy, id: @bus_list
      assert_response :redirect
      assert_redirected_to root_path
    end
  end

  context "while authenticated as a read-only admin" do
    setup do
      @user = create(:read_only_admin)
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @user
    end

    should "allow access to manage_bus_lists#index" do
      get :index
      assert_response :success
    end

    should "allow access to manage_bus_lists#show" do
      get :show, id: @bus_list
      assert_response :success
    end

    should "not allow access to manage_bus_lists#new" do
      get :new
      assert_response :redirect
      assert_redirected_to manage_bus_lists_path
    end

    should "not allow access to manage_bus_lists#edit" do
      get :edit, id: @bus_list
      assert_response :redirect
      assert_redirected_to manage_bus_lists_path
    end

    should "not allow access to manage_bus_lists#create" do
      post :create, bus_list: { email: "test@example.com" }
      assert_response :redirect
      assert_redirected_to manage_bus_lists_path
    end

    should "not allow access to manage_bus_lists#update" do
      put :update, id: @bus_list, bus_list: { email: "test@example.com" }
      assert_response :redirect
      assert_redirected_to manage_bus_lists_path
    end

    should "not allow access to manage_bus_lists#destroy" do
      put :destroy, id: @bus_list
      assert_response :redirect
      assert_redirected_to manage_bus_lists_path
    end
  end

  context "while authenticated as an admin" do
    setup do
      @user = create(:admin)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
    end

    should "allow access to manage_bus_lists#index" do
      get :index
      assert_response :success
    end

    should "create a new bus_list" do
      post :create, bus_list: { name: "New bus_list Name" }
      assert_response :redirect
      assert_redirected_to manage_bus_list_path(assigns(:bus_list))
    end

    should "allow access to manage_bus_lists#show" do
      get :show, id: @bus_list
      assert_response :success
    end

    should "allow access to manage_bus_lists#edit" do
      get :edit, id: @bus_list
      assert_response :success
    end

    should "update bus_list" do
      put :update, id: @bus_list, bus_list: { name: "New bus_list Name" }
      assert_redirected_to manage_bus_list_path(assigns(:bus_list))
    end

    should "destroy bus_list" do
      assert_difference('BusList.count', -1) do
        put :destroy, id: @bus_list
      end
      assert_redirected_to manage_bus_lists_path
    end
  end
end
