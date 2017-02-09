require 'test_helper'

class Manage::BusListsControllerTest < ActionController::TestCase
  before do
    ActionMailer::Base.deliveries = []
    Sidekiq::Extensions::DelayedMailer.jobs.clear
  end

  setup do
    @bus_list = create(:bus_list)
    questionnaire = create(:questionnaire, riding_bus: true, acc_status: 'rsvp_confirmed')
    questionnaire.school.update_attribute(:bus_list_id, @bus_list.id)
  end

  context "while not authenticated" do
    should "redirect to sign in page on manage_bus_lists#index" do
      get :index
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_bus_lists#new" do
      get :new
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_bus_lists#show" do
      get :show, params: { id: @bus_list }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_bus_lists#edit" do
      get :edit, params: { id: @bus_list }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_bus_lists#create" do
      post :create, params: { bus_list: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_bus_lists#update" do
      patch :update, params: { id: @bus_list, bus_list: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_bus_lists#toggle_bus_captain" do
      questionnaire = create(:questionnaire)
      patch :toggle_bus_captain, params: { id: @bus_list, questionnaire_id: questionnaire.id, bus_captain: '1' }
      assert_equal false, questionnaire.reload.is_bus_captain
      assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_bus_lists#send_update_email" do
      patch :send_update_email, params: { id: @bus_list }
      assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_bus_lists#destroy" do
      patch :destroy, params: { id: @bus_list }
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

    should "not allow access to manage_bus_lists#new" do
      get :new
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_bus_lists#show" do
      get :show, params: { id: @bus_list }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_bus_lists#edit" do
      get :edit, params: { id: @bus_list }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_bus_lists#create" do
      post :create, params: { bus_list: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_bus_lists#update" do
      patch :update, params: { id: @bus_list, bus_list: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_bus_lists#toggle_bus_captain" do
      questionnaire = create(:questionnaire)
      patch :toggle_bus_captain, params: { id: @bus_list, questionnaire_id: questionnaire.id, bus_captain: '1' }
      assert_equal false, questionnaire.reload.is_bus_captain
      assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_bus_lists#send_update_email" do
      patch :send_update_email, params: { id: @bus_list }
      assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_bus_lists#destroy" do
      patch :destroy, params: { id: @bus_list }
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

    should "allow access to manage_bus_lists#index" do
      get :index
      assert_response :success
    end

    should "allow access to manage_bus_lists#show" do
      get :show, params: { id: @bus_list }
      assert_response :success
    end

    should "not allow access to manage_bus_lists#new" do
      get :new
      assert_response :redirect
      assert_redirected_to manage_bus_lists_path
    end

    should "not allow access to manage_bus_lists#edit" do
      get :edit, params: { id: @bus_list }
      assert_response :redirect
      assert_redirected_to manage_bus_lists_path
    end

    should "not allow access to manage_bus_lists#create" do
      post :create, params: { bus_list: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to manage_bus_lists_path
    end

    should "not allow access to manage_bus_lists#update" do
      patch :update, params: { id: @bus_list, bus_list: { email: "test@example.com" } }
      assert_response :redirect
      assert_redirected_to manage_bus_lists_path
    end

    should "not allow access to manage_bus_lists#toggle_bus_captain" do
      questionnaire = create(:questionnaire)
      patch :toggle_bus_captain, params: { id: @bus_list, questionnaire_id: questionnaire.id, bus_captain: '1' }
      assert_equal false, questionnaire.reload.is_bus_captain
      assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size
      assert_response :redirect
      assert_redirected_to manage_bus_lists_path
    end

    should "not allow access to manage_bus_lists#send_update_email" do
      patch :send_update_email, params: { id: @bus_list }
      assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size
      assert_response :redirect
      assert_redirected_to manage_bus_lists_path
    end

    should "not allow access to manage_bus_lists#destroy" do
      patch :destroy, params: { id: @bus_list }
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

    should "allow access to manage_bus_lists#new" do
      get :new
      assert_response :success
    end

    should "create a new bus_list" do
      post :create, params: { bus_list: { name: "New bus_list Name" } }
      assert_response :redirect
      assert_redirected_to manage_bus_list_path(assigns(:bus_list))
    end

    should "allow access to manage_bus_lists#show" do
      get :show, params: { id: @bus_list }
      assert_response :success
    end

    should "render markdown in manage_bus_lists#show" do
      @bus_list.update_attribute(:notes, '### This is a title')
      get :show, params: { id: @bus_list }
      assert_response :success
      assert_select "fieldset h3", "This is a title"
    end

    should "render html in manage_bus_lists#show" do
      @bus_list.update_attribute(:notes, '<h3>This is a title</h3>')
      get :show, params: { id: @bus_list }
      assert_response :success
      assert_select "fieldset h3", "This is a title"
    end

    should "allow access to manage_bus_lists#edit" do
      get :edit, params: { id: @bus_list }
      assert_response :success
    end

    should "update bus_list" do
      patch :update, params: { id: @bus_list, bus_list: { name: "New bus_list Name" } }
      assert_redirected_to manage_bus_list_path(assigns(:bus_list))
    end

    should "make questionnaire a bus captain" do
      questionnaire = create(:questionnaire)
      patch :toggle_bus_captain, params: { id: @bus_list, questionnaire_id: questionnaire.id, bus_captain: '1' }
      assert_equal true, questionnaire.reload.is_bus_captain
      assert_equal 1, Sidekiq::Extensions::DelayedMailer.jobs.size
      assert_response :redirect
      assert_redirected_to manage_bus_list_path(@bus_list)
    end

    should "remove questionnaire from being a bus captain" do
      questionnaire = create(:questionnaire)
      patch :toggle_bus_captain, params: { id: @bus_list, questionnaire_id: questionnaire.id, bus_captain: '0' }
      assert_equal false, questionnaire.reload.is_bus_captain
      assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size
      assert_response :redirect
      assert_redirected_to manage_bus_list_path(@bus_list)
    end

    should "send email upon manage_bus_lists#send_update_email" do
      patch :send_update_email, params: { id: @bus_list }
      assert_equal 1, Sidekiq::Extensions::DelayedMailer.jobs.size
      assert_response :redirect
      assert_redirected_to manage_bus_list_path(@bus_list)
    end

    context "#destroy" do
      should "destroy bus_list" do
        assert_difference('BusList.count', -1) do
          patch :destroy, params: { id: @bus_list }
        end
        assert_redirected_to manage_bus_lists_path
      end

      should "reset school's bus list association" do
        school = create(:school, bus_list_id: @bus_list.id)
        patch :destroy, params: { id: @bus_list }
        assert_nil school.reload.bus_list_id
      end

      should "reset everyone's riding_bus status" do
        school = create(:school, bus_list_id: @bus_list.id)
        questionnaire = create(:questionnaire, school: school)
        questionnaire2 = create(:questionnaire, school: school)
        patch :destroy, params: { id: @bus_list }
        assert_equal false, questionnaire.reload.riding_bus
        assert_equal false, questionnaire2.reload.riding_bus
      end
    end
  end
end
