require "test_helper"

class MembershipsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @team = teams(:team_one)
    @other_team = teams(:team_two)
    @first_user = users(:michael)
    @second_user = users(:archer)
  end
  # getting members index for team
  test "should get members index as owner" do
    get team_teams_relationships_url(@team),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
    assert_response :success
  end

  test "should get members index as member" do
    get team_teams_relationships_url(@other_team),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
    assert_response :success
  end

  test "should not get members index when user is not a member" do
    get team_teams_relationships_url(@team),
      headers: { 'Authorization' => "#{User.new_token(@second_user)}" }, as: :json
    assert_response :forbidden
  end

  test "should not get members index without authorization header" do
    get team_teams_relationships_url(@team), as: :json
    assert_response :forbidden
  end

  test "should not get members index with empty authorization header" do
    get team_teams_relationships_url(@team),
      headers: { 'Authorization' => "" }, as: :json
    assert_response :forbidden
  end

  # getting memberships index for user
  test "should get your own memberships index" do
    get user_teams_relationships_url(@first_user),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
    assert_response :success
  end

  test "should not get memberships index for another user" do
    get user_teams_relationships_url(@first_user),
      headers: { 'Authorization' => "#{User.new_token(@second_user)}" }, as: :json
    assert_response :forbidden
  end

  test "should not get memberships index without authorization header" do
    get user_teams_relationships_url(@first_user), as: :json
    assert_response :forbidden
  end

  test "should not get memberships index with empty authorization header" do
    get user_teams_relationships_url(@first_user),
      headers: { 'Authorization' => "" }, as: :json
    assert_response :forbidden
  end
end
