require "test_helper"

class TeamsShowTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @first_team = teams(:team_one)
    @second_user = users(:archer)
  end
  
  test "should show team" do
    get team_path(@first_team),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
    assert_response :success
  end
  
  test "should show team to other users" do
    get team_path(@first_team),
      headers: { 'Authorization' => "#{User.new_token(@second_user)}" }
    assert_response :success
  end

  test "should not show team without authorization header" do
    get team_path(@first_team)
    assert_response :forbidden
  end

  test "should not show team will empty authorization header" do
    get team_path(@first_team),
      headers: { 'Authorization' => "" }
    assert_response :forbidden
  end

  test "should not show team with empty authorization label for token" do
    get team_path(@first_team),
      headers: { '' => "#{User.new_token(@first_user)}"}
    assert_response :forbidden
  end
end
