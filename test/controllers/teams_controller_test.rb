require "test_helper"

class TeamsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @first_team = teams(:team_one)
  end
  test "should get show" do
    get teams_path(@first_team),
    headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
    assert_response :success
  end

  test "should get index" do
    get teams_path,
    headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
    
    assert_response :success
  end

  test "should get create" do
    post teams_path,
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
      params: {
        team: {
        name: "second team",
        description: 'second description' }
      }
    assert_response :success
  end

  test "should get update" do
    patch team_path(@first_team),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
      params: {
        team: {
        name: "team",
        description: 'description' }
      }
      assert_response :success
  end

  test "should get destroy" do
    delete team_path(@first_team),
    headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
    assert_response :success
  end
end
