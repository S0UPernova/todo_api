require "test_helper"

class UsersDestroyTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @first_team = teams(:team_one)
    @first_team_relationship_one = teams_relationships(:first_user_first_team)
    @request_to_first_team = team_requests(:two)
    @request_from_first_team = team_requests(:four)
    @second_user = users(:archer)
  end

  test "should delete user" do
    assert_difference('User.count', -1) do
      delete user_path(@first_user),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
      assert_response :success
    end
  end
  
  test "deleting user should destroy teams that the user owns" do
    assert_difference('Team.count', -1) do
      delete user_path(@first_user),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
      assert_response :success
    end
  end
  
  test "deleting user should destroy team relationships for the user" do
    assert_difference('TeamsRelationship.count', -2) do
      delete user_path(@first_user),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
      assert_response :success
    end
  end
  
  test "deleting user should destroy team requests for the user" do
    assert_difference('TeamRequest.count', -3) do
      delete user_path(@first_user),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
      assert_response :success
    end
  end

  test "deleting user should destroy projects for the users teams" do
    assert_difference('Project.count', -2) do
      delete user_path(@first_user),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
      assert_response :success
    end
  end

  test "deleting user should destroy tasks for the users teams projects" do
    assert_difference('Task.count', -2) do
      delete user_path(@first_user),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
      assert_response :success
    end
  end
  
  test "should not delete user with incorrect token" do
    assert_no_difference('User.count') do
      delete user_path(@first_user),
        headers: { 'Authorization' => "#{User.new_token(@second_user)}" }
      assert_response :forbidden
    end
  end

  test "should not delete user without authorization header" do
    assert_no_difference('User.count') do
      delete user_path(@first_user)
      assert_response :forbidden
    end
  end

  test "should not delete user will empty authorization header" do
    assert_no_difference('User.count') do
      delete user_path(@first_user),
        headers: { 'Authorization' => "" }
      assert_response :forbidden
    end
  end

  test "should not delete user with empty authorization label for token" do
    assert_no_difference('User.count') do
      delete user_path(@first_user),
        headers: { '' => "#{User.new_token(@first_user)}"}
      assert_response :forbidden
    end
  end
end
