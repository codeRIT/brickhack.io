require 'test_helper'

class QuestionnairesControllerTest < ActionController::TestCase

  before do
    ActionMailer::Base.deliveries = []
    Sidekiq::Extensions::DelayedMailer.jobs.clear
  end

  setup do
    @school = create(:school, name: "Another School")
    @questionnaire = create(:questionnaire, school_id: @school.id)
  end

  context "while not authenticated" do
    should "redirect to sign up page on questionnaire#index" do
      get :index
      assert_redirected_to new_user_session_path
    end

    should "redirect to sign up page on questionnaire#new" do
      get :new
      assert_redirected_to new_user_session_path
    end

    should "redirect to sign up page on questionnaire#edit" do
      get :edit, id: @questionnaire
      assert_redirected_to new_user_session_path
    end

    should "redirect to sign up page on questionnaire#update" do
      put :update, id: @questionnaire, questionnaire: { city: "different" }
      assert_redirected_to new_user_session_path
    end

    should "redirect to sign up page on questionnaire#destroy" do
      assert_difference('Questionnaire.count', 0) do
        delete :destroy, id: @questionnaire
      end
      assert_redirected_to new_user_session_path
    end

    context "accessing a non-owned questionnaire" do
      should "not allow #show" do
        get :show, id: 0
        assert_response :redirect
        assert_redirected_to new_user_session_path
      end

      should "not allow #edit" do
        get :edit, id: 0
        assert_response :redirect
        assert_redirected_to new_user_session_path
      end

      should "not not allow #update" do
        put :update, id: 3, questionnaire: { first_name: "Foo" }
        assert_response :redirect
        assert_redirected_to new_user_session_path
      end
    end
  end

  context "while authenticated without a completed questionnaire" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @user = create(:user, email: "newabc@example.com")
      sign_in @user
    end

    should "get new" do
      get :new
      assert_response :success
    end

    should "create questionnaire" do
      assert_difference('Questionnaire.count', 1) do
        post :create, questionnaire: { city: @questionnaire.city, experience: @questionnaire.experience, first_name: @questionnaire.first_name, interest: @questionnaire.interest, last_name: @questionnaire.last_name, phone: @questionnaire.phone, state: @questionnaire.state, year: @questionnaire.year, birthday: @questionnaire.birthday, shirt_size: @questionnaire.shirt_size, school_id: @school.id, agreement_accepted: "1" }
      end

      assert_redirected_to questionnaire_path(assigns(:questionnaire))
    end

    should "not allow multiple questionnaires" do
      assert_difference('Questionnaire.count', 1) do
        post :create, questionnaire: { city: @questionnaire.city, experience: @questionnaire.experience, first_name: @questionnaire.first_name, interest: @questionnaire.interest, last_name: @questionnaire.last_name, phone: @questionnaire.phone, state: @questionnaire.state, year: @questionnaire.year, birthday: @questionnaire.birthday, shirt_size: @questionnaire.shirt_size, school_id: @school.id, agreement_accepted: "1" }
        post :create, questionnaire: { city: @questionnaire.city, experience: @questionnaire.experience, first_name: @questionnaire.first_name, interest: @questionnaire.interest, last_name: @questionnaire.last_name, phone: @questionnaire.phone, state: @questionnaire.state, year: @questionnaire.year, birthday: @questionnaire.birthday, shirt_size: @questionnaire.shirt_size, school_id: @school.id, agreement_accepted: "1" }
      end

      assert_redirected_to questionnaire_path(assigns(:questionnaire))
    end

    context "#school_name" do
      context "on create" do
        should "save existing school name" do
          post :create, questionnaire: { city: @questionnaire.city, experience: @questionnaire.experience, first_name: @questionnaire.first_name, interest: @questionnaire.interest, last_name: @questionnaire.last_name, phone: @questionnaire.phone, state: @questionnaire.state, year: @questionnaire.year, birthday: @questionnaire.birthday, shirt_size: @questionnaire.shirt_size, school_name: @school.name, agreement_accepted: "1" }
          assert_redirected_to questionnaire_path(assigns(:questionnaire))
          assert_equal 1, School.all.count
          assert_equal "late_waitlist", assigns(:questionnaire).acc_status, "should automatically waitlist"
        end

        should "create a new school when unknown" do
          post :create, questionnaire: { city: @questionnaire.city, experience: @questionnaire.experience, first_name: @questionnaire.first_name, interest: @questionnaire.interest, last_name: @questionnaire.last_name, phone: @questionnaire.phone, state: @questionnaire.state, year: @questionnaire.year, birthday: @questionnaire.birthday, shirt_size: @questionnaire.shirt_size, school_name: "New School", agreement_accepted: "1" }
          assert_redirected_to questionnaire_path(assigns(:questionnaire))
          assert_equal 2, School.all.count
        end

        should "send confirmation email to questionnaire" do
          assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size, "no emails should be queued prior to questionnaire creation"
          post :create, questionnaire: { city: @questionnaire.city, experience: @questionnaire.experience, first_name: @questionnaire.first_name, interest: @questionnaire.interest, last_name: @questionnaire.last_name, phone: @questionnaire.phone, state: @questionnaire.state, year: @questionnaire.year, birthday: @questionnaire.birthday, shirt_size: @questionnaire.shirt_size, school_name: @school.name, agreement_accepted: "1" }
          assert_equal 1, Sidekiq::Extensions::DelayedMailer.jobs.size, "should email confirmation to questionnaire"
        end
      end
    end
  end

  context "while authenticated with a completed questionnaire" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @questionnaire.user
    end

    should "index should redirect to new" do
      get :index
      assert_response :redirect
      assert_redirected_to new_questionnaire_path
    end

    should "show questionnaire" do
      get :show, id: @questionnaire
      assert_response :success
    end

    should "get edit" do
      get :edit, id: @questionnaire
      assert_response :success
    end

    should "update questionnaire" do
      put :update, id: @questionnaire, questionnaire: { first_name: "Foo" }
      assert_redirected_to questionnaire_path(assigns(:questionnaire))
    end

    should "destroy questionnaire" do
      assert_difference('Questionnaire.count', -1) do
        delete :destroy, id: @questionnaire
      end

      assert_redirected_to questionnaires_path
    end

    context "accessing a non-owned questionnaire" do
      should "not allow #show" do
        get :show, id: 0
        assert_response :redirect
        assert_redirected_to questionnaire_path(@questionnaire)
      end

      should "not allow #edit" do
        get :edit, id: 0
        assert_response :redirect
        assert_redirected_to questionnaire_path(@questionnaire)
      end

      should "not not allow #update" do
        put :update, id: 3, questionnaire: { first_name: "Foo" }
        assert_response :redirect
        assert_redirected_to questionnaire_path(@questionnaire)
      end

      should "redirect to #new if a questionnaire has not been submitted" do
        @questionnaire.delete
        get :show, id: 0
        assert_response :redirect
        assert_redirected_to new_questionnaire_path
      end
    end

    context "#school_name" do
      context "on update" do
        should "save existing school name" do
          put :update, id: @questionnaire, questionnaire: { school_name: @school.name }
          assert_redirected_to questionnaire_path(assigns(:questionnaire))
          assert_equal 1, School.all.count
        end

        should "create a new school when unknown" do
          put :update, id: @questionnaire, questionnaire: { school_name: "New School" }
          assert_redirected_to questionnaire_path(assigns(:questionnaire))
          assert_equal 2, School.all.count
        end
      end
    end

    context "#schools" do
      should "not respond to search with no query" do
        get :schools
        assert_response 400
        assert_blank @response.body
      end

      should "not respond to search with short query" do
        get :schools, school: "Al"
        assert_response 400
        assert_blank @response.body
      end

      should "respond to school search" do
        create(:school, id: 2, name: "Alpha University")
        create(:school, id: 3, name: "Pheta College")
        get :schools, name: "Alph"
        assert_response :success
        assert_equal 1, json_response.count
        assert_equal "Alpha University", json_response[0]
      end
    end
  end

  private

  def json_response
    ActiveSupport::JSON.decode @response.body
  end
end
