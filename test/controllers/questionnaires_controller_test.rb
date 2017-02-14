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
    should "redirect to sign up page on questionnaire#new" do
      get :new
      assert_redirected_to new_user_session_path
    end

    should "redirect to sign up page on questionnaire#edit" do
      get :edit
      assert_redirected_to new_user_session_path
    end

    should "redirect to sign up page on questionnaire#update" do
      patch :update, params: { questionnaire: { major: "different" } }
      assert_redirected_to new_user_session_path
    end

    should "redirect to sign up page on questionnaire#destroy" do
      assert_difference('Questionnaire.count', 0) do
        delete :destroy
      end
      assert_redirected_to new_user_session_path
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
        post :create, params: { questionnaire: { experience: @questionnaire.experience, interest: @questionnaire.interest, first_name: @questionnaire.first_name, last_name: @questionnaire.last_name, phone: @questionnaire.phone, level_of_study: @questionnaire.level_of_study, date_of_birth: @questionnaire.date_of_birth, shirt_size: @questionnaire.shirt_size, school_id: @school.id, agreement_accepted: "1", code_of_conduct_accepted: "1", data_sharing_accepted: "1", major: @questionnaire.major, gender: @questionnaire.gender } }
      end

      assert_redirected_to questionnaires_path
      if Rails.configuration.hackathon['auto_late_waitlist']
        assert_equal "late_waitlist", assigns(:questionnaire).acc_status
      else
        assert_equal "pending", assigns(:questionnaire).acc_status
      end
    end

    should "not allow multiple questionnaires" do
      assert_difference('Questionnaire.count', 1) do
        post :create, params: { questionnaire: { experience: @questionnaire.experience, interest: @questionnaire.interest, first_name: @questionnaire.first_name, last_name: @questionnaire.last_name, phone: @questionnaire.phone, level_of_study: @questionnaire.level_of_study, date_of_birth: @questionnaire.date_of_birth, shirt_size: @questionnaire.shirt_size, school_id: @school.id, agreement_accepted: "1", code_of_conduct_accepted: "1", data_sharing_accepted: "1", major: @questionnaire.major, gender: @questionnaire.gender } }
        post :create, params: { questionnaire: { experience: @questionnaire.experience, interest: @questionnaire.interest, first_name: @questionnaire.first_name, last_name: @questionnaire.last_name, phone: @questionnaire.phone, level_of_study: @questionnaire.level_of_study, date_of_birth: @questionnaire.date_of_birth, shirt_size: @questionnaire.shirt_size, school_id: @school.id, agreement_accepted: "1", code_of_conduct_accepted: "1", data_sharing_accepted: "1", major: @questionnaire.major, gender: @questionnaire.gender } }
      end

      assert_redirected_to questionnaires_path
    end

    context "with an invalid questionnaire" do
      should "not allow creation" do
        @questionnaire.delete
        assert_difference('Questionnaire.count', 0) do
          post :create, params: { questionnaire: { first_name: "My first name" } }
        end
      end
    end

    context "#school_name" do
      context "on create" do
        should "save existing school name" do
          post :create, params: { questionnaire: { experience: @questionnaire.experience, interest: @questionnaire.interest, first_name: @questionnaire.first_name, last_name: @questionnaire.last_name, phone: @questionnaire.phone, level_of_study: @questionnaire.level_of_study, date_of_birth: @questionnaire.date_of_birth, shirt_size: @questionnaire.shirt_size, school_name: @school.name, agreement_accepted: "1", code_of_conduct_accepted: "1", data_sharing_accepted: "1", major: @questionnaire.major, gender: @questionnaire.gender } }
          assert_redirected_to questionnaires_path
          assert_equal 1, School.all.count
        end

        should "create a new school when unknown" do
          post :create, params: { questionnaire: { experience: @questionnaire.experience, interest: @questionnaire.interest, first_name: @questionnaire.first_name, last_name: @questionnaire.last_name, phone: @questionnaire.phone, level_of_study: @questionnaire.level_of_study, date_of_birth: @questionnaire.date_of_birth, shirt_size: @questionnaire.shirt_size, school_name: "New School", agreement_accepted: "1", code_of_conduct_accepted: "1", data_sharing_accepted: "1", major: @questionnaire.major, gender: @questionnaire.gender } }
          assert_redirected_to questionnaires_path
          assert_equal 2, School.all.count
        end

        should "send confirmation email to questionnaire" do
          assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size, "no emails should be queued prior to questionnaire creation"
          post :create, params: { questionnaire: { experience: @questionnaire.experience, interest: @questionnaire.interest, first_name: @questionnaire.first_name, last_name: @questionnaire.last_name, phone: @questionnaire.phone, level_of_study: @questionnaire.level_of_study, date_of_birth: @questionnaire.date_of_birth, shirt_size: @questionnaire.shirt_size, school_name: @school.name, agreement_accepted: "1", code_of_conduct_accepted: "1", data_sharing_accepted: "1", major: @questionnaire.major, gender: @questionnaire.gender } }
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

    should "show questionnaire" do
      get :show
      assert_response :success
    end

    should "get edit" do
      get :edit
      assert_response :success
    end

    should "get edit with questionnaire resume" do
      @questionnaire.resume = sample_file("sample_pdf.pdf")
      @questionnaire.save
      get :edit
      assert_response :success
    end

    should "update questionnaire" do
      patch :update, params: { questionnaire: { first_name: "Foo" } }
      assert_redirected_to questionnaires_path
    end

    should "destroy questionnaire" do
      assert_difference('Questionnaire.count', -1) do
        delete :destroy
      end

      assert_redirected_to questionnaires_path
    end

    context "with invalid questionnaire params" do
      should "not allow updates" do
        saved_first_name = @questionnaire.first_name
        patch :update, params: { questionnaire: { first_name: "" } }
        assert_equal saved_first_name, @questionnaire.reload.first_name
      end
    end

    context "accessing #new after already submitting a questionnaire" do
      should "redirect to existing questionnaire" do
        get :new
        assert_response :redirect
        assert_redirected_to questionnaires_path
      end
    end

    context "#school_name" do
      context "on update" do
        should "save existing school name" do
          patch :update, params: { questionnaire: { school_name: @school.name } }
          assert_redirected_to questionnaires_path
          assert_equal 1, School.all.count
        end

        should "create a new school when unknown" do
          patch :update, params: { questionnaire: { school_name: "New School" } }
          assert_redirected_to questionnaires_path
          assert_equal 2, School.all.count
        end
      end
    end

    context "#schools" do
      should "not respond to search with no query" do
        get :schools
        assert_response 400
        assert @response.body.blank?
      end

      should "not respond to search with short query" do
        get :schools, params: { school: "Al" }
        assert_response 400
        assert @response.body.blank?
      end

      should "respond to school search" do
        create(:school, name: "Alpha University")
        create(:school, name: "Pheta College")
        get :schools, params: { name: "Alph" }
        assert_response :success
        assert_equal 1, json_response.count
        assert_equal "Alpha University", json_response[0]
      end

      should "prioritize schools with more applicants" do
        create(:school, name: "Alpha College", questionnaire_count: 0)
        create(:school, name: "Pheta College", questionnaire_count: 5)
        get :schools, params: { name: "Coll" }
        assert_response :success
        assert_equal "Pheta College", json_response[0]
      end
    end
  end

  private

  def json_response
    ActiveSupport::JSON.decode @response.body
  end
end
