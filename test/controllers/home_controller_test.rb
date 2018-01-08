require 'test_helper'

class HomeControllerTest < ActionController::TestCase
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
end
