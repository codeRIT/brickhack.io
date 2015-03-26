require 'test_helper'

class RsvpsControllerTest < ActionController::TestCase
  before do
    ActionMailer::Base.deliveries = []
    Sidekiq::Extensions::DelayedMailer.jobs.clear
  end

  setup do
    @school = create(:school, name: "Another School")
    @questionnaire = create(:questionnaire, school_id: @school.id)
  end

  context "while not authenticated" do
    should "redirect to sign in page on rsvp#index" do
      get :show
      assert_redirected_to new_user_session_path
    end

    should "redirect to sign in page on rsvp#accept" do
      get :accept
      assert_redirected_to new_user_session_path
    end

    should "redirect to sign in page on rsvp#deny" do
      get :deny
      assert_redirected_to new_user_session_path
    end

    should "redirect to sign in page on rsvp#update" do
      put :update
      assert_redirected_to new_user_session_path
    end
  end

  context "while authenticated without a questionnaire" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @user = create(:user, email: "newabc@example.com")
      sign_in @user
    end

    should "redirect to root page on rsvp#index" do
      get :show
      assert_redirected_to root_path
    end

    should "redirect to root page on rsvp#accept" do
      get :accept
      assert_redirected_to root_path
    end

    should "redirect to root page on rsvp#deny" do
      get :deny
      assert_redirected_to root_path
    end

    should "redirect to root page on rsvp#update" do
      put :update
      assert_redirected_to root_path
    end
  end

  context "while authenticated with a non-accepted questionnaire" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @questionnaire.user
      @questionnaire.acc_status = "denied"
    end

    should "redirect to root page on rsvp#index" do
      get :show
      assert_redirected_to root_path
    end

    should "redirect to root page on rsvp#accept" do
      get :accept
      assert_redirected_to root_path
    end

    should "redirect to root page on rsvp#deny" do
      get :deny
      assert_redirected_to root_path
    end

    should "redirect to root page on rsvp#update" do
      put :update
      assert_redirected_to root_path
    end
  end

  context "while authenticated with an accepted questionnaire" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @questionnaire.user
      @questionnaire.update_attribute(:acc_status, "accepted")
    end

    should "display rsvp page" do
      get :show
      assert_response :success
    end

    should "update the questionnaire status to accepted" do
      get :accept
      assert_equal "rsvp_confirmed", @questionnaire.reload.acc_status # reload not needed?
      assert_redirected_to rsvp_path
    end

    should "update the questionnaire status to denied" do
      get :deny
      assert_equal "rsvp_denied", @questionnaire.reload.acc_status # reload not needed?
      assert_redirected_to rsvp_path
    end

    should "redirect to root page on rsvp#update" do
      put :update, questionnaire: { acc_status: "rsvp_denied" }
      assert_equal "rsvp_denied", @questionnaire.reload.acc_status
      assert_redirected_to rsvp_path
    end
  end

end
