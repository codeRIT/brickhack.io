require 'test_helper'

class Manage::StatsControllerTest < ActionController::TestCase
  context "while not authenticated" do
    should "redirect to sign in page on manage_dashboard#index" do
      get :index
      assert_response :redirect
      assert_redirected_to new_user_session_path
    end

    should "redirect to sign in page on data endpoints" do
      paths.each do |path|
        patch path
        assert_response :redirect
        assert_redirected_to new_user_session_path
      end
    end
  end

  context "while authenticated as a user" do
    setup do
      @user = create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @user
    end

    should "not allow access to manage_dashboard#index" do
      get :index
      assert_response :redirect
      assert_redirected_to root_path
    end

    should "not allow access to data endpoints" do
      paths.each do |path|
        patch path
        assert_response :redirect
        assert_redirected_to root_path
      end
    end
  end

  context "while authenticated as an admin" do
    setup do
      @user = create(:admin)
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @user
    end

    should "allow access to manage_dashboard#index" do
      get :index
      assert_response :success
    end

    should "allow access to all data endpoints" do
      school = create(:school)
      Questionnaire::POSSIBLE_ACC_STATUS.each do |status, _name|
        create_list(:questionnaire, 5, school_id: school.id, acc_status: status, dietary_restrictions: "Vegetarian", special_needs: "Something")
      end

      paths.each do |path|
        patch path
        assert_response :success
      end
    end
  end

  private

  def paths
    [:dietary_special_needs, :sponsor_info, :alt_travel, :mlh_info]
  end
end
