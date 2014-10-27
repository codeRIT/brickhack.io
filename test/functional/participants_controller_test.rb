require 'test_helper'

class ParticipantsControllerTest < ActionController::TestCase
  setup do
    @participant = create(:participant)
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
      post :create, participant: { city: @participant.city, email: @participant.email, experience: @participant.experience, first_name: @participant.first_name, interest: @participant.interest, last_name: @participant.last_name, state: @participant.state, year: @participant.year }
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
    put :update, id: @participant, participant: { city: @participant.city, email: @participant.email, experience: @participant.experience, first_name: @participant.first_name, interest: @participant.interest, last_name: @participant.last_name, state: @participant.state, year: @participant.year }
    assert_redirected_to participant_path(assigns(:participant))
  end

  test "should destroy participant" do
    assert_difference('Participant.count', -1) do
      delete :destroy, id: @participant
    end

    assert_redirected_to participants_path
  end
end
