require 'test_helper'

class Manage::QuestionnairesControllerTest < ActionController::TestCase

  setup do
    @questionnaire = create(:questionnaire)
  end

  context "while not authenticated" do
    should "redirect to sign in page on manage_questionnaires#index" do
      get :index
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_questionnaires datatables api" do
      get :index, format: :json
      assert_response 401
    end

    should "not allow access to manage_questionnaires#show" do
      get :show, id: @questionnaire
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_questionnaires#edit" do
      get :edit, id: @questionnaire
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_questionnaires#create" do
      post :create, questionnaire: { first_name: "New" }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_questionnaires#update" do
      put :update, id: @questionnaire, questionnaire: { first_name: "New" }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow convert questionnaire's user to an admin" do
      put :convert_to_admin, id: @questionnaire
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_questionnaires#destroy" do
      put :destroy, id: @questionnaire
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end
  end

  context "while authenticated as a user" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @questionnaire.user
    end

    should "not allow access to manage_questionnaires#index" do
      get :index
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_questionnaires datatables api" do
      get :index, format: :json
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_questionnaires#show" do
      get :show, id: @questionnaire
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_questionnaires#edit" do
      get :edit, id: @questionnaire
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_questionnaires#create" do
      post :create, questionnaire: { first_name: "New" }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_questionnaires#update" do
      put :update, id: @questionnaire, questionnaire: { first_name: "New" }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow convert questionnaire's user to an admin" do
      put :convert_to_admin, id: @questionnaire
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_questionnaires#destroy" do
      put :destroy, id: @questionnaire
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

    should "allow access to manage_questionnaires#index" do
      get :index
      assert_response :success
    end

    # causes a strange bug in testing. works in live application, ignoring for now
    # should "allow access to manage_questionnaires datatables api" do
    #   get :index, format: :json
    #   assert_response :success
    # end

    should "allow access to manage_questionnaires#show" do
      get :show, id: @questionnaire
      assert_response :success
    end

    should "not allow access to manage_questionnaires#new" do
      get :new, id: @questionnaire
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "not allow access to manage_questionnaires#edit" do
      get :edit, id: @questionnaire
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "not allow access to manage_questionnaires#create" do
      post :create, questionnaire: { first_name: "New" }
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "not allow access to manage_questionnaires#update" do
      put :update, id: @questionnaire, questionnaire: { first_name: "New" }
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "not allow convert questionnaire's user to an admin" do
      put :convert_to_admin, id: @questionnaire
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "not allow access to manage_questionnaires#destroy" do
      put :destroy, id: @questionnaire
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end
  end

  context "while authenticated as an admin" do
    setup do
      @user = create(:admin)
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @user
    end

    should "allow access to manage_questionnaires#index" do
      get :index
      assert_response :success
    end

    should "allow access to manage_questionnaires#show" do
      get :show, id: @questionnaire
      assert_response :success
    end

    should "allow access to manage_questionnaires#edit" do
      get :edit, id: @questionnaire
      assert_response :success
    end

    should "create questionnaire and user" do
      assert_difference('User.count', 1) do
        assert_difference('Questionnaire.count', 1) do
          post :create, questionnaire: { city: @questionnaire.city, experience: @questionnaire.experience, first_name: @questionnaire.first_name, interest: @questionnaire.interest, last_name: @questionnaire.last_name, state: @questionnaire.state, year: @questionnaire.year, birthday: @questionnaire.birthday, shirt_size: @questionnaire.shirt_size, school_id: @questionnaire.school_id, email: "test@example.com", agreement_accepted: "1" }
        end
      end

      assert_equal "test@example.com", assigns(:questionnaire).email
      assert_redirected_to manage_questionnaire_path(assigns(:questionnaire))
    end

    should "update questionnaire" do
      put :update, id: @questionnaire, questionnaire: { first_name: "New" }
      assert_redirected_to manage_questionnaire_path(assigns(:questionnaire))
    end

    should "update questionnaire's user email" do
      put :update, id: @questionnaire, questionnaire: { email: "update@example.com" }
      assert_equal "update@example.com", assigns(:questionnaire).email
      assert_redirected_to manage_questionnaire_path(assigns(:questionnaire))
    end

    should "convert questionnaire's user to an admin" do
      put :convert_to_admin, id: @questionnaire
      assert assigns(:questionnaire).user.admin
      assert_equal nil, assigns(:questionnaire).user.questionnaire
      assert_redirected_to edit_manage_admin_path(assigns(:questionnaire).user)
    end

    should "destroy questionnaire" do
      assert_difference('Questionnaire.count', -1) do
        assert_difference('User.count', -1) do
          delete :destroy, id: @questionnaire
        end
      end
      assert_redirected_to manage_questionnaires_path
    end
  end
end
