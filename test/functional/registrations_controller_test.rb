require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase

  before do
    ActionMailer::Base.deliveries = []
    Sidekiq::Extensions::DelayedMailer.jobs.clear
  end

  setup do
    @school = create(:school, name: "Another School")
    @registration = create(:registration, school_id: @school.id)
  end

  test "index should redirect to new" do
    get :index
    assert_response :redirect
    assert_redirected_to new_registration_path
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create registration" do
    assert_difference('Registration.count') do
      post :create, registration: { city: @registration.city, email: @registration.email, experience: @registration.experience, first_name: @registration.first_name, interest: @registration.interest, last_name: @registration.last_name, state: @registration.state, year: @registration.year, birthday: @registration.birthday, shirt_size: @registration.shirt_size, school_id: @school.id }
    end

    assert_redirected_to registration_path(assigns(:registration))
  end

  test "should show registration" do
    get :show, id: @registration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @registration
    assert_response :success
  end

  test "should update registration" do
    put :update, id: @registration, registration: { email: "new@example.com" }
    assert_redirected_to registration_path(assigns(:registration))
  end

  test "should destroy registration" do
    assert_difference('Registration.count', -1) do
      delete :destroy, id: @registration
    end

    assert_redirected_to registrations_path
  end

  context "#school_name" do
    context "on create" do
      should "save existing school name" do
        post :create, registration: { city: @registration.city, email: @registration.email, experience: @registration.experience, first_name: @registration.first_name, interest: @registration.interest, last_name: @registration.last_name, state: @registration.state, year: @registration.year, birthday: @registration.birthday, shirt_size: @registration.shirt_size, school_name: @school.name }
        assert_redirected_to registration_path(assigns(:registration))
        assert_equal 1, School.all.count
      end

      should "create a new school when unknown" do
        post :create, registration: { city: @registration.city, email: @registration.email, experience: @registration.experience, first_name: @registration.first_name, interest: @registration.interest, last_name: @registration.last_name, state: @registration.state, year: @registration.year, birthday: @registration.birthday, shirt_size: @registration.shirt_size, school_name: "New School" }
        assert_redirected_to registration_path(assigns(:registration))
        assert_equal 2, School.all.count
      end

      should "send confirmation email to registration" do
        assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size, "no emails should be queued prior to registration creation"
        post :create, registration: { city: @registration.city, email: @registration.email, experience: @registration.experience, first_name: @registration.first_name, interest: @registration.interest, last_name: @registration.last_name, state: @registration.state, year: @registration.year, birthday: @registration.birthday, shirt_size: @registration.shirt_size, school_name: @school.name }
        assert_equal 1, Sidekiq::Extensions::DelayedMailer.jobs.size, "should email confirmation to registration"
      end
    end

    context "on update" do
      should "save existing school name" do
        put :update, id: @registration, registration: { school_name: @school.name }
        assert_redirected_to registration_path(assigns(:registration))
        assert_equal 1, School.all.count
      end

      should "create a new school when unknown" do
        put :update, id: @registration, registration: { school_name: "New School" }
        assert_redirected_to registration_path(assigns(:registration))
        assert_equal 2, School.all.count
      end
    end
  end

  context "#schools" do
    should "not respond to search with no query" do
      get :schools
      assert_response 400
      assert_blank @response.body
    end

    should "not respond to search with short query" do
      get :schools, school: "Al"
      assert_response 400
      assert_blank @response.body
    end

    should "respond to school search" do
      create(:school, id: 2, name: "Alpha University")
      create(:school, id: 3, name: "Pheta College")
      get :schools, name: "Alph"
      assert_response :success
      assert_equal 1, json_response.count
      assert_equal "Alpha University", json_response[0]
    end
  end

  private

  def json_response
    ActiveSupport::JSON.decode @response.body
  end
end
