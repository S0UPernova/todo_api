require "test_helper"

class MembershipsShowTest < ActionDispatch::IntegrationTest
  def setup
    @team = teams(:team_one)
    @other_team = teams(:team_two)
    @first_user = users(:michael)
    @second_user = users(:archer)
    @first_membership = teams_relationships(:first_user_first_team)
    @second_membership = teams_relationships(:first_user_second_team)
  end

  # show membership as team
  test "should show teams first membership" do
    get team_teams_relationship_url(@team, @first_membership),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
      as: :json
    assert_response :success
  end

  test "should show teams second membership" do
    get team_teams_relationship_url(@other_team, @second_membership),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
      as: :json
    assert_response :success
  end

  test "should not show second membership with incorrect path" do
    get team_teams_relationship_url(@team, @second_membership),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
      as: :json
    assert_response :forbidden
  end
  
  test "should not show teams membership to non member token" do
    get team_teams_relationship_url(@team, @first_membership),
      headers: { 'Authorization' => "#{User.new_token(@second_user)}" },
      as: :json
    assert_response :forbidden
  end

  test "should not show teams membership without authorization header" do
    get team_teams_relationship_url(@team, @first_membership),
    as: :json
    assert_response :forbidden
  end

  test "should not show teams membership with empty authorization header" do
    get team_teams_relationship_url(@team, @first_membership),
      headers: { 'Authorization' => "" }, as: :json
    assert_response :forbidden
  end
 
  # show membership as user
  test "should show users first membership" do
    get user_teams_relationship_url(@first_user, @first_membership),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
      as: :json
    assert_response :success
  end

  test "should show users second membership" do
    get user_teams_relationship_url(@first_user, @second_membership),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
      as: :json
    assert_response :success
  end

  test "should not show membership with incorrect token" do
    get user_teams_relationship_url(@first_user, @first_membership),
      headers: { 'Authorization' => "#{User.new_token(@second_user)}" },
      as: :json
    assert_response :forbidden
  end

  test "should not show users membership without authorization header" do
    get user_teams_relationship_url(@first_user, @first_membership),
    as: :json
    assert_response :forbidden
  end

  test "should not show users membership with empty authorization header" do
    get user_teams_relationship_url(@first_user, @first_membership),
      headers: { 'Authorization' => "" }, as: :json
    assert_response :forbidden
  end
end
