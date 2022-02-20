require "test_helper"

class MembershipRequestIndexTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @second_user = users(:archer)
    @first_team = teams(:team_one)
    @second_team = teams(:team_two)
  end
  
  
  # requests index for user

  test "should get index for user" do
    get user_team_requests_url(@first_user),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
    assert_response :success
    assert_equal 'application/json', response.content_type
    assert_equal [@second_team].to_json, response.body
  end

  test "should not get index for another user" do
    get user_team_requests_url(@first_user),
      headers: { 'Authorization' => "#{User.new_token(@second_user)}" }, as: :json
    assert_response :forbidden
    assert_equal 'application/json', response.content_type
    assert_empty response.body
  end
  
  test "should not get index for user with empty authorization header" do
    get user_team_requests_url(@first_user),
      headers: { 'Authorization' => "" }, as: :json
    assert_response :forbidden
    assert_equal 'application/json', response.content_type
  end

  test "should not get index for user without authorization header" do
    get user_team_requests_url(@first_user), as: :json
    assert_response :forbidden
    assert_equal 'application/json', response.content_type
  end
  

  # requests index for team

  test "should get index for team" do
    get team_team_requests_url(@second_team),
      headers: { 'Authorization' => "#{User.new_token(@second_user)}" }, as: :json
    assert_response :success
    assert_equal 'application/json', response.content_type
    assert_equal [@first_user].to_json, response.body
  end

  test "should not get index for another team" do
    get team_team_requests_url(@first_team),
      headers: { 'Authorization' => "#{User.new_token(@second_user)}" }, as: :json
    assert_response :forbidden
    assert_equal 'application/json', response.content_type
    assert_empty response.body
  end
  
  test "should not get index for team with empty authorization header" do
    get team_team_requests_url(@first_team),
      headers: { 'Authorization' => "" }, as: :json
    assert_response :forbidden
    assert_equal 'application/json', response.content_type
  end

  test "should not get index for team without authorization header" do
    get team_team_requests_url(@first_team), as: :json
    assert_response :forbidden
    assert_equal 'application/json', response.content_type
  end
end
