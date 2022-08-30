require "test_helper"

class TeamsDiscoverTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @third_user = users(:trey)
    @first_team = teams(:team_one)
    @second_team = teams(:team_two)
    @third_team = teams(:team_three)
  end
  
  test "should show team" do
    get teams_discover_path,
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
    assert_response :success
    assert @response.body.include?(@third_team.to_json)
  end

  test "should not show teams that user owns or is a member in" do
    get teams_discover_path,
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
    assert_response :success
    assert_not @response.body.include?(@first_team.to_json)
    assert_not @response.body.include?(@second_team.to_json)
  end
  
  # I might want to change this one later if I add a recommendation algorithm
  test "should show all teams if user is not in one" do
    get teams_discover_path,
      headers: { 'Authorization' => "#{User.new_token(@third_user)}" }
    assert_response :success

    assert @response.body.include?(@first_team.to_json)
    assert @response.body.include?(@second_team.to_json)
    assert @response.body.include?(@third_team.to_json)
  end
end
