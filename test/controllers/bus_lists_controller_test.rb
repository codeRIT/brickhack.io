require 'test_helper'

class BusListsControllerTest < ActionController::TestCase
  setup do
    @school = create(:school, name: "Another School")
    @questionnaire = create(:questionnaire, school_id: @school.id)
  end

  context "while not authenticated" do
    should "redirect to sign in page on bus_list#show" do
      get :show
      assert_redirected_to new_user_session_path
    end
  end

  context "while authenticated without a questionnaire" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @user = create(:user, email: "newabc@example.com")
      sign_in @user
    end

    should "redirect to root page on bus_list#show" do
      get :show
      assert_redirected_to root_path
    end
  end

  context "while authenticated with a questionnaire but no bus list" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @questionnaire.user
      @questionnaire.update_attribute(:acc_status, "accepted")
    end

    should "redirect to root page on bus_list#show" do
      get :show
      assert_redirected_to root_path
    end
  end

  context "while authenticated with a questionnaire with a bus list" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @questionnaire.user
      @questionnaire.update_attribute(:acc_status, "accepted")
      @questionnaire.update_attribute(:riding_bus, true)
      @bus_list = create(:bus_list)
      @school.update_attribute(:bus_list_id, @bus_list.id)
    end

    context "but is not bus captain" do
      should "redirect to root page on bus_list#show" do
        get :show
        assert_redirected_to root_path
      end
    end

    context "and is bus captain" do
      should "redirect to root page on bus_list#show" do
        @questionnaire.update_attribute(:is_bus_captain, true)
        get :show
        assert_response :success
      end
    end
  end
end
