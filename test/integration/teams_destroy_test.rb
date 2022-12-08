require "test_helper"

class TeamsDestroyTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @first_team = teams(:team_one)
    @first_team_relationship_one = teams_relationships(:first_user_first_team)
    @request_to_first_team = team_requests(:two)
    @request_from_first_team = team_requests(:four)
    @second_user = users(:archer)
  end

  test "should delete team" do
    assert_difference('Team.count', -1) do
      delete team_path(@first_team),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
      assert_response :success
    end
  end
  
  test "deleting team should destroy team relationships for the team" do
    assert_difference('TeamsRelationship.count', -1) do
      delete team_path(@first_team),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
      assert_response :success
    end
  end
  
  test "deleting team should destroy team requests for the team" do
    assert_difference('TeamRequest.count', -2) do
      delete team_path(@first_team),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
      assert_response :success
    end
  end

  test "deleting team should destroy projects for the team" do
    assert_difference('Project.count', -2) do
      delete team_path(@first_team),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
      assert_response :success
    end
  end

  test "deleting team should destroy task for the teams projects" do
    assert_difference('Task.count', -2) do
      delete team_path(@first_team),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
      assert_response :success
    end
  end
  
  test "should not delete team with incorrect token" do
    delete team_path(@first_team),
      headers: { 'Authorization' => "#{User.new_token(@second_user)}" }
    assert_response :forbidden
  end

  test "should not delete team without authorization header" do
    delete team_path(@first_team)
    assert_response :forbidden
  end

  test "should not delete team will empty authorization header" do
    delete team_path(@first_team),
      headers: { 'Authorization' => "" }
    assert_response :forbidden
  end

  test "should not delete team with empty authorization label for token" do
    delete team_path(@first_team),
      headers: { '' => "#{User.new_token(@first_user)}"}
    assert_response :forbidden
  end
end
