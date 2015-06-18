require 'test_helper'

class ParticipantTeamsControllerTest < ActionController::TestCase
  setup do
    @participant_team = participant_teams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:participant_teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create participant_team" do
    assert_difference('ParticipantTeam.count') do
      post :create, participant_team: { participant_id: @participant_team.participant_id, team_id: @participant_team.team_id }
    end

    assert_redirected_to participant_team_path(assigns(:participant_team))
  end

  test "should show participant_team" do
    get :show, id: @participant_team
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @participant_team
    assert_response :success
  end

  test "should update participant_team" do
    patch :update, id: @participant_team, participant_team: { participant_id: @participant_team.participant_id, team_id: @participant_team.team_id }
    assert_redirected_to participant_team_path(assigns(:participant_team))
  end

  test "should destroy participant_team" do
    assert_difference('ParticipantTeam.count', -1) do
      delete :destroy, id: @participant_team
    end

    assert_redirected_to participant_teams_path
  end
end
