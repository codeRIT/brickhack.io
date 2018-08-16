require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  should "render index successfully" do
    get :index
    assert_response :success
  end

  should "render comingsoon successfully" do
    get :comingsoon
    assert_response :success
  end

  should "render design_category successfully" do
    get :design_category
    assert_response :success
  end

  should "render apilist successfully" do
    get :apilist
    assert_response :success
  end

  context "while not authenticated" do
    should "not display incomplete notice" do
      get :index
      assert_select ".flashes", false
    end
  end

  context "while authenticated with a complete questionnaire" do
    setup do
      @questionnaire = create(:questionnaire)
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @questionnaire.user
    end

    should "not display incomplete notice" do
      get :index
      assert_select ".flashes", false
    end
  end

  context "while authenticated with an accepted questionnaire" do
    setup do
      @questionnaire = create(:questionnaire, acc_status: 'accepted')
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @questionnaire.user
    end

    should "display RSVP notice" do
      get :index
      assert_select ".flashes", /RSVP now/
    end
  end

  context "while authenticated with an RSVP'd questionnaire" do
    setup do
      @questionnaire = create(:questionnaire, acc_status: 'rsvp_confirmed')
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @questionnaire.user
    end

    should "not display RSVP notice" do
      get :index
      assert_select ".flashes", false
    end
  end

  context "while authenticated with an incomplete questionnaire" do
    setup do
      @user = create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @user
    end

    should "display incomplete notice" do
      get :index
      assert_select ".flashes", /Your application is incomplete/
    end
  end
end
