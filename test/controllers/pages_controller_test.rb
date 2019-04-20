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

  should "render live successfully" do
    get :live
    assert_response :success
  end

  context "while not authenticated" do
    should "not display incomplete notice" do
      get :index
      assert_select ".flashes", false
    end
  end
end
