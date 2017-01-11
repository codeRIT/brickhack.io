require 'test_helper'

class Users::RegistrationsControllerTest < ActionController::TestCase
  setup do
    @questionnaire = create(:questionnaire)
  end

  context "while authenticated with a completed questionnaire" do
    setup do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @questionnaire.user
    end

    should "destroy both user and questionnaire" do
      assert_difference('User.count', -1) do
        assert_difference('Questionnaire.count', -1) do
          delete :destroy, params: { id: @questionnaire.user }
        end
      end

      assert_redirected_to root_path
    end
  end
end
