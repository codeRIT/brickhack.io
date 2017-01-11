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
      patch :update
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
      assert_redirected_to new_questionnaires_path
    end

    should "redirect to root page on rsvp#accept" do
      get :accept
      assert_redirected_to new_questionnaires_path
    end

    should "redirect to root page on rsvp#deny" do
      get :deny
      assert_redirected_to new_questionnaires_path
    end

    should "redirect to root page on rsvp#update" do
      patch :update
      assert_redirected_to new_questionnaires_path
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
      assert_redirected_to new_questionnaires_path
    end

    should "redirect to root page on rsvp#accept" do
      get :accept
      assert_redirected_to new_questionnaires_path
    end

    should "redirect to root page on rsvp#deny" do
      get :deny
      assert_redirected_to new_questionnaires_path
    end

    should "redirect to root page on rsvp#update" do
      patch :update
      assert_redirected_to new_questionnaires_path
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

    should "not update status for invalid questionnaire" do
      [:accept, :deny].each do |status|
        @questionnaire.update_attribute(:agreement_accepted, false)
        @questionnaire.update_attribute(:acc_status, "accepted")
        get status
        assert_match /error/, flash[:notice]
        assert_equal "accepted", @questionnaire.reload.acc_status
      end
    end

    should "update the questionnaire status to accepted" do
      get :accept
      assert_equal "rsvp_confirmed", @questionnaire.reload.acc_status
      assert_equal 1, Sidekiq::Extensions::DelayedMailer.jobs.size, "should email confirmation to questionnaire"
      assert_redirected_to rsvp_path
    end

    should "update the questionnaire status to denied" do
      get :deny
      assert_equal "rsvp_denied", @questionnaire.reload.acc_status
      assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size, "no emails should be sent"
      assert_redirected_to rsvp_path
    end

    should "redirect to root page on rsvp#update" do
      patch :update, params: { questionnaire: { acc_status: "rsvp_denied" } }
      assert_equal "rsvp_denied", @questionnaire.reload.acc_status
      assert_redirected_to rsvp_path
    end

    should "not allow riding a bus if school does not have bus list" do
      patch :update, params: { questionnaire: { acc_status: "rsvp_confirmed", riding_bus: "true" } }
      assert_equal "rsvp_confirmed", @questionnaire.reload.acc_status
      assert_equal false, @questionnaire.reload.riding_bus
      assert_equal 1, Sidekiq::Extensions::DelayedMailer.jobs.size, "should email confirmation to questionnaire"
      assert_redirected_to rsvp_path
    end

    should "not allow riding a bus if bus is full" do
      bus_list = create(:bus_list, capacity: 0)
      @questionnaire.school.update_attribute(:bus_list_id, bus_list.id)
      patch :update, params: { questionnaire: { acc_status: "rsvp_confirmed", riding_bus: "true" } }
      assert_equal "rsvp_confirmed", @questionnaire.reload.acc_status
      assert_equal false, @questionnaire.reload.riding_bus
      assert_equal 0, bus_list.passengers.count
      assert_match /full/, flash[:notice]
      assert_redirected_to rsvp_path
    end

    should "not send email if updating info after confirming" do
      @questionnaire.update_attribute(:acc_status, "rsvp_confirmed")
      patch :update, params: { questionnaire: { acc_status: "rsvp_confirmed", riding_bus: "true" } }
      assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size, "no emails should be sent"
    end

    should "allow riding a bus if school has bus list" do
      bus_list = create(:bus_list)
      @questionnaire.school.update_attribute(:bus_list_id, bus_list.id)
      patch :update, params: { questionnaire: { acc_status: "rsvp_confirmed", riding_bus: "true" } }
      assert_equal "rsvp_confirmed", @questionnaire.reload.acc_status
      assert_equal true, @questionnaire.reload.riding_bus
      assert_equal 1, bus_list.passengers.count
      assert_redirected_to rsvp_path
    end

    should "allow updates to questionnaire via rsvp page" do
      patch :update, params: { questionnaire: { phone: "1234567890" } }
      assert_equal "1234567890", @questionnaire.reload.phone
      assert_redirected_to rsvp_path
    end

    should "not allow invalid updates to questionnaire via rsvp page" do
      @questionnaire.update_attribute(:phone, "1111111111")
      @questionnaire.update_attribute(:agreement_accepted, false)
      patch :update, params: { questionnaire: { phone: "1234567890" } }
      assert_not_nil flash[:notice]
      assert_equal "1111111111", @questionnaire.reload.phone
      assert_redirected_to rsvp_path
    end

    should "not allow updates to invalid questionnaire via rsvp page" do
      @questionnaire.update_attribute(:phone, "1111111111")
      @questionnaire.update_attribute(:first_name, "")
      patch :update, params: { questionnaire: { phone: "1234567890" } }
      assert_not_nil flash[:notice]
      assert_equal "1111111111", @questionnaire.reload.phone
      assert_redirected_to rsvp_path
    end

    should "not allow forbidden status update to questionnaire" do
      patch :update, params: { questionnaire: { acc_status: "pending" } }
      assert_equal "accepted", @questionnaire.reload.acc_status
      assert_match /select a RSVP status/, flash[:notice]
      assert_redirected_to rsvp_path
    end
  end
end
