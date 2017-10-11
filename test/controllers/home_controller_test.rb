require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get design_category" do
    get :design_category
    assert_response :success
  end

  test "should get apilist" do
    get :apilist
    assert_response :success
  end
end
