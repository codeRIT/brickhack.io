require 'test_helper'

class Manage::QuestionnairesControllerTest < ActionController::TestCase

  before do
    ActionMailer::Base.deliveries = []
    Sidekiq::Extensions::DelayedMailer.jobs.clear
  end

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
      post :datatable, format: :json
      assert_response 401
    end

    should "not allow access to manage_questionnaires#new" do
      get :new
      assert_response :redirect
      assert_redirected_to new_user_session_path
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
      patch :update, id: @questionnaire, questionnaire: { first_name: "New" }
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow convert questionnaire's user to an admin" do
      patch :convert_to_admin, id: @questionnaire
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_questionnaires#destroy" do
      patch :destroy, id: @questionnaire
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_questionnaires#update_acc_status" do
      patch :update_acc_status, id: @questionnaire
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "not allow access to manage_questionnaires#bulk_apply" do
      patch :bulk_apply, id: @questionnaire
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
      post :datatable, format: :json
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_questionnaires#new" do
      get :new
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
      patch :update, id: @questionnaire, questionnaire: { first_name: "New" }
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow convert questionnaire's user to an admin" do
      patch :convert_to_admin, id: @questionnaire
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_questionnaires#destroy" do
      patch :destroy, id: @questionnaire
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_questionnaires#update_acc_status" do
      patch :update_acc_status, id: @questionnaire
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to manage_questionnaires#bulk_apply" do
      patch :bulk_apply, id: @questionnaire
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

    should "allow access to manage_questionnaires#index" do
      get :index
      assert_response :success
    end

    should "allow access to manage_questionnaires datatables api" do
      post :datatable, format: :json
      assert_response :success
    end

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
      patch :update, id: @questionnaire, questionnaire: { first_name: "New" }
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "not allow convert questionnaire's user to an admin" do
      patch :convert_to_admin, id: @questionnaire
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "not allow access to manage_questionnaires#destroy" do
      patch :destroy, id: @questionnaire
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "allow access to manage_questionnaires#update_acc_status" do
      patch :update_acc_status, id: @questionnaire, questionnaire: { acc_status: "accepted" }
      assert_equal "accepted", @questionnaire.reload.acc_status
      assert_equal @user.id, @questionnaire.reload.acc_status_author_id
      assert_not_equal nil, @questionnaire.reload.acc_status_date
      assert_equal nil, flash[:notice]
      assert_response :redirect
      assert_redirected_to manage_questionnaire_path @questionnaire
    end

    should "allow access to manage_questionnaires#bulk_apply" do
      patch :bulk_apply, bulk_action: "waitlist", bulk_ids: [@questionnaire.id]
      assert_response :success
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

    should "allow access to manage_questionnaires#new" do
      get :new
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
          post :create, questionnaire: { experience: @questionnaire.experience, first_name: @questionnaire.first_name, last_name: @questionnaire.last_name, phone: @questionnaire.phone, graduation: @questionnaire.graduation, date_of_birth: @questionnaire.date_of_birth, shirt_size: @questionnaire.shirt_size, school_id: @questionnaire.school_id, email: "test@example.com", agreement_accepted: "1", code_of_conduct_accepted: "1", gender: @questionnaire.gender, major: @questionnaire.major }
        end
      end

      assert_equal "test@example.com", assigns(:questionnaire).email
      assert_redirected_to manage_questionnaire_path(assigns(:questionnaire))
    end

    should "not create a questionnaire with invalid user" do
      create(:user, email: "taken@example.com")
      assert_difference('User.count', 0) do
        assert_difference('Questionnaire.count', 0) do
          post :create, questionnaire: { experience: @questionnaire.experience, first_name: @questionnaire.first_name, last_name: @questionnaire.last_name, phone: @questionnaire.phone, graduation: @questionnaire.graduation, date_of_birth: @questionnaire.date_of_birth, shirt_size: @questionnaire.shirt_size, school_id: @questionnaire.school_id, email: "taken@example.com", agreement_accepted: "1", code_of_conduct_accepted: "1", gender: @questionnaire.gender, major: @questionnaire.major }
        end
      end
      assert_match /Email has already been taken/, flash[:notice]
      assert_response :success
    end

    should "create school if doesn't exist in questionnaire" do
      assert_difference('Questionnaire.count', 1) do
        assert_difference('School.count', 1) do
          post :create, questionnaire: { experience: @questionnaire.experience, first_name: @questionnaire.first_name, last_name: @questionnaire.last_name, phone: @questionnaire.phone, graduation: @questionnaire.graduation, date_of_birth: @questionnaire.date_of_birth, shirt_size: @questionnaire.shirt_size, school_name: "My New School", email: "taken@example.com", agreement_accepted: "1", code_of_conduct_accepted: "1", gender: @questionnaire.gender, major: @questionnaire.major }
        end
      end
      assert_equal "My New School", assigns(:questionnaire).school.name
    end

    should "update questionnaire" do
      patch :update, id: @questionnaire, questionnaire: { first_name: "New" }
      assert_redirected_to manage_questionnaire_path(assigns(:questionnaire))
    end

    should "update questionnaire's user email" do
      patch :update, id: @questionnaire, questionnaire: { email: "update@example.com" }
      assert_equal "update@example.com", assigns(:questionnaire).email
      assert_redirected_to manage_questionnaire_path(assigns(:questionnaire))
    end

    should "convert questionnaire's user to an admin" do
      patch :convert_to_admin, id: @questionnaire
      assert assigns(:questionnaire).user.admin
      assert_equal nil, assigns(:questionnaire).user.reload.questionnaire
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

    should "check in the questionnaire" do
      patch :check_in, id: @questionnaire, check_in: "true"
      assert 1.minute.ago < @questionnaire.reload.checked_in_at
      assert_equal @user.id, @questionnaire.reload.checked_in_by_id
      assert_match /Checked in/, flash[:notice]
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "check in the questionnaire and update information" do
      @questionnaire.update_attribute(:agreement_accepted, false)
      @questionnaire.update_attribute(:can_share_resume, false)
      @questionnaire.update_attribute(:phone, "")
      patch :check_in, id: @questionnaire, check_in: "true", questionnaire: { agreement_accepted: 1, can_share_resume: 1, phone: "(123) 333-3333" }
      @questionnaire.reload
      assert 1.minute.ago < @questionnaire.checked_in_at
      assert_equal @user.id, @questionnaire.checked_in_by_id
      assert_equal true, @questionnaire.agreement_accepted
      assert_equal true, @questionnaire.can_share_resume
      assert_equal "(123) 333-3333", @questionnaire.phone
      assert_match /Checked in/, flash[:notice]
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "require a new action to check in" do
      @questionnaire.update_attribute(:agreement_accepted, false)
      @questionnaire.update_attribute(:can_share_resume, false)
      @questionnaire.update_attribute(:phone, "")
      @questionnaire.update_attribute(:checked_in_at, nil)
      @questionnaire.update_attribute(:checked_in_by_id, nil)
      patch :check_in, id: @questionnaire, check_in: "", questionnaire: { agreement_accepted: 1, can_share_resume: 1, phone: "(123) 333-3333" }
      @questionnaire.reload
      assert_equal nil, @questionnaire.checked_in_at
      assert_equal nil, @questionnaire.checked_in_by_id
      assert_equal false, @questionnaire.agreement_accepted
      assert_equal false, @questionnaire.can_share_resume
      assert_equal "", @questionnaire.phone
      assert_match /No check-in action provided/, flash[:notice]
      assert_response :redirect
      assert_redirected_to manage_questionnaire_path(@questionnaire)
    end

    should "require agreement_accepted to check in" do
      @questionnaire.update_attribute(:agreement_accepted, false)
      patch :check_in, id: @questionnaire, check_in: "true"
      assert_equal nil, @questionnaire.reload.checked_in_at
      assert_equal nil, @questionnaire.reload.checked_in_by_id
      assert_response :redirect
      assert_redirected_to manage_questionnaire_path(@questionnaire)
    end

    should "accept agreement and check in" do
      @questionnaire.update_attribute(:agreement_accepted, false)
      patch :check_in, id: @questionnaire, check_in: "true", questionnaire: { agreement_accepted: 1 }
      assert 1.minute.ago < @questionnaire.reload.checked_in_at
      assert_equal @user.id, @questionnaire.reload.checked_in_by_id
      assert_response :redirect
      assert_redirected_to manage_questionnaires_path
    end

    should "undo check in of the questionnaire" do
      patch :check_in, id: @questionnaire, check_in: "false"
      assert_equal nil, @questionnaire.reload.checked_in_at
      assert_equal @user.id, @questionnaire.reload.checked_in_by_id
      assert_response :redirect
      assert_match /no longer/, flash[:notice]
      assert_redirected_to manage_questionnaires_path
    end

    should "allow access to manage_questionnaires#update_acc_status" do
      patch :update_acc_status, id: @questionnaire, questionnaire: { acc_status: "accepted" }
      assert_equal "accepted", @questionnaire.reload.acc_status
      assert_equal @user.id, @questionnaire.reload.acc_status_author_id
      assert_not_equal nil, @questionnaire.reload.acc_status_date
      assert_response :redirect
      assert_redirected_to manage_questionnaire_path @questionnaire
    end

    should "allow access to manage_questionnaires#bulk_apply" do
      patch :bulk_apply, bulk_action: "accepted", bulk_ids: [@questionnaire.id]
      assert_response :success
      assert_equal "accepted", @questionnaire.reload.acc_status
    end

    should "fail manage_questionnaires#bulk_apply when missing action" do
      patch :bulk_apply, bulk_ids: [@questionnaire.id]
      assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size
      assert_response 400
    end

    should "fail manage_questionnaires#bulk_apply when missing ids" do
      patch :bulk_apply, id: @questionnaire
      assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size
      assert_response 400
    end

    ["accepted", "denied", "rsvp_confirmed"].each do |status|
      should "send notification emails appropriately for #{status} bulk_apply" do
        assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size, "no emails should be sent prior"
        patch :bulk_apply, bulk_action: status, bulk_ids: [@questionnaire.id]
        assert_equal 1, Sidekiq::Extensions::DelayedMailer.jobs.size, "questionnaire should be notified"
      end
    end

    should "fail manage_questionnaires#update_acc_status when missing status" do
      patch :update_acc_status, id: @questionnaire, questionnaire: { acc_status: "" }
      assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size
      assert_response :redirect
    end

    ["accepted", "denied", "rsvp_confirmed"].each do |status|
      should "send notification emails appropriately for #{status} update_acc_status" do
        assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size, "no emails should be sent prior"
        patch :update_acc_status, id: @questionnaire, questionnaire: { acc_status: status }
        assert_equal 1, Sidekiq::Extensions::DelayedMailer.jobs.size, "questionnaire should be notified"
      end
    end
  end
end
