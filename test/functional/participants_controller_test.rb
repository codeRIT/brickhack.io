require 'test_helper'

class ParticipantsControllerTest < ActionController::TestCase

  before do
    ActionMailer::Base.deliveries = []
    Sidekiq::Extensions::DelayedMailer.jobs.clear
  end

  setup do
    @school = create(:school, name: "Another School")
    @participant = create(:participant, school_id: @school.id)
  end

  test "index should redirect to new" do
    get :index
    assert_response :redirect
    assert_redirected_to new_participant_path
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create participant" do
    assert_difference('Participant.count') do
      post :create, participant: { city: @participant.city, email: @participant.email, experience: @participant.experience, first_name: @participant.first_name, interest: @participant.interest, last_name: @participant.last_name, state: @participant.state, year: @participant.year, birthday: @participant.birthday, shirt_size: @participant.shirt_size, school_id: @school.id }
    end

    assert_redirected_to participant_path(assigns(:participant))
  end

  test "should show participant" do
    get :show, id: @participant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @participant
    assert_response :success
  end

  test "should update participant" do
    put :update, id: @participant, participant: { email: "new@example.com" }
    assert_redirected_to participant_path(assigns(:participant))
  end

  test "should destroy participant" do
    assert_difference('Participant.count', -1) do
      delete :destroy, id: @participant
    end

    assert_redirected_to participants_path
  end

  context "#school_name" do
    context "on create" do
      should "save existing school name" do
        post :create, participant: { city: @participant.city, email: @participant.email, experience: @participant.experience, first_name: @participant.first_name, interest: @participant.interest, last_name: @participant.last_name, state: @participant.state, year: @participant.year, birthday: @participant.birthday, shirt_size: @participant.shirt_size, school_name: @school.name }
        assert_redirected_to participant_path(assigns(:participant))
        assert_equal 1, School.all.count
      end

      should "create a new school when unknown" do
        post :create, participant: { city: @participant.city, email: @participant.email, experience: @participant.experience, first_name: @participant.first_name, interest: @participant.interest, last_name: @participant.last_name, state: @participant.state, year: @participant.year, birthday: @participant.birthday, shirt_size: @participant.shirt_size, school_name: "New School" }
        assert_redirected_to participant_path(assigns(:participant))
        assert_equal 2, School.all.count
      end

      should "send confirmation email to participant" do
        assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size, "no emails should be queued prior to participant creation"
        post :create, participant: { city: @participant.city, email: @participant.email, experience: @participant.experience, first_name: @participant.first_name, interest: @participant.interest, last_name: @participant.last_name, state: @participant.state, year: @participant.year, birthday: @participant.birthday, shirt_size: @participant.shirt_size, school_name: @school.name }
        assert_equal 1, Sidekiq::Extensions::DelayedMailer.jobs.size, "should email confirmation to participant"
      end
    end

    context "on update" do
      should "save existing school name" do
        put :update, id: @participant, participant: { school_name: @school.name }
        assert_redirected_to participant_path(assigns(:participant))
        assert_equal 1, School.all.count
      end

      should "create a new school when unknown" do
        put :update, id: @participant, participant: { school_name: "New School" }
        assert_redirected_to participant_path(assigns(:participant))
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
