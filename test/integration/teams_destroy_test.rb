require "test_helper"

class TeamsDestroyTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @first_team = teams(:team_one)
    @second_user = users(:archer)
  end

  test "should delete team" do
    delete team_path(@first_team),
    headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
    assert_response :success
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
