require "test_helper"

class MembershipsDestroyTest < ActionDispatch::IntegrationTest
  def setup
    @team = teams(:team_one)
    @other_team = teams(:team_two)
    @first_user = users(:michael)
    @second_user = users(:archer)
    @first_membership = teams_relationships(:first_user_first_team)
    @second_membership = teams_relationships(:first_user_second_team)
  end

  # delete membership as team
  test "should delete teams first membership" do
    assert_difference 'TeamsRelationship.count', -1 do
      delete team_teams_relationship_url(@team, @first_membership),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
        as: :json
      end
      assert_response :success
  end

  test "should delete teams second membership" do
    assert_difference 'TeamsRelationship.count', -1 do
      delete team_teams_relationship_url(@other_team, @second_membership),
        headers: { 'Authorization' => "#{User.new_token(@second_user)}" },
        as: :json
      end
      assert_response :success
  end
  
  test "should not delete teams membership to non member token" do
    assert_no_difference 'TeamsRelationship.count' do
      delete team_teams_relationship_url(@team, @first_membership),
        headers: { 'Authorization' => "#{User.new_token(@second_user)}" },
        as: :json
      end
      assert_response :forbidden
  end

  test "should not delete teams membership without authorization header" do
    assert_no_difference 'TeamsRelationship.count' do
      delete team_teams_relationship_url(@team, @first_membership),
      as: :json
    end
    assert_response :forbidden
  end

  test "should not delete teams membership with empty authorization header" do
    assert_no_difference 'TeamsRelationship.count' do
      delete team_teams_relationship_url(@team, @first_membership),
        headers: { 'Authorization' => "" }, as: :json
      end
      assert_response :forbidden
  end
 
  # delete membership as user
  
  test "should delete users first membership" do
    assert_difference 'TeamsRelationship.count', -1 do
      delete user_teams_relationship_url(@first_user, @first_membership),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
        as: :json
      end
      assert_response :success
  end

  test "should delete users second membership" do
    assert_difference 'TeamsRelationship.count', -1 do
      delete user_teams_relationship_url(@first_user, @second_membership),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
        as: :json
      end
      assert_response :success
  end

  test "should not delete membership with incorrect token" do
    assert_no_difference 'TeamsRelationship.count' do
      delete user_teams_relationship_url(@first_user, @first_membership),
        headers: { 'Authorization' => "#{User.new_token(@second_user)}" },
        as: :json
      end
      assert_response :forbidden
  end

  test "should not delete users membership without authorization header" do
    assert_no_difference 'TeamsRelationship.count' do
      delete user_teams_relationship_url(@first_user, @first_membership),
      as: :json
    end
    assert_response :forbidden
  end

  test "should not delete users membership with empty authorization header" do
    assert_no_difference 'TeamsRelationship.count' do
      delete user_teams_relationship_url(@first_user, @first_membership),
        headers: { 'Authorization' => "" }, as: :json
      end
      assert_response :forbidden
  end
end