require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  should "be able to login and browse site" do
    user = login(FactoryGirl.create(:user))
    admin = login(FactoryGirl.create(:admin))

    user.assert_redirected_to new_questionnaires_path
    admin.assert_redirected_to manage_root_path

    user.browse_questionnaire
    admin.browse_admin
  end

  should "redirect to attempted page after login" do
    get manage_questionnaires_path
    assert_response :redirect
    user = login(FactoryGirl.create(:admin))
    user.assert_redirected_to manage_questionnaires_path
  end

  should "redirect to completed application after login" do
    questionnaire = FactoryGirl.create(:questionnaire)
    applied_user = login(questionnaire.user)
    applied_user.assert_redirected_to questionnaires_path
  end

  private

    module CustomDsl
      def browse_questionnaire
        get new_questionnaires_path
        assert_response :success
        assert assigns(:questionnaire)
      end

      def browse_admin
        get manage_dashboard_index_path
        assert_response :success
        get manage_questionnaires_path
        assert_response :success
      end
    end

    def login(user)
      open_session do |sess|
        sess.extend(CustomDsl)
        sess.https!
        sess.post user_session_url, user: { email: user.email, password: user.password }
        assert_equal 'Signed in successfully.', sess.flash[:notice]
      end
    end
end
