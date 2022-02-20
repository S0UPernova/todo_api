require "test_helper"

class MembershipRequestShowTest < ActionDispatch::IntegrationTest
  def setup
    @team_request = team_requests(:one)
    @team = teams(:team_one)
    @other_team = teams(:team_two)
    @first_user = users(:michael)
    @second_user = users(:archer)
    @third_user = users(:trey)
  end
  # testing user/requests path

  test "should show request as user" do
    get user_team_request_url(@first_user, @team_request),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
    assert_response :success
    assert_equal 'application/json', response.content_type
  end
  
  test "should not show request to team owner using user path" do
    get user_team_request_url(@first_user, @team_request),
      headers: { 'Authorization' => "#{User.new_token(@second_user)}" }, as: :json
    assert_response :forbidden
    assert_equal 'application/json', response.content_type
    assert_equal "{}", response.body
  end

  test "should not show request to user that isn't the correct user" do
    get user_team_request_url(@first_user, @team_request),
      headers: { 'Authorization' => "#{User.new_token(@third_user)}" }, as: :json
    assert_response :forbidden
    assert_equal 'application/json', response.content_type
    assert_equal "{}", response.body
  end

  test "should not show request to user with empty authorization header" do
    get user_team_request_url(@first_user, @team_request),
      headers: { 'Authorization' => "" }, as: :json
    assert_response :forbidden
    assert_equal 'application/json', response.content_type
  end

  test "should not show request to user without authorization header" do
    get user_team_request_url(@first_user, @team_request), as: :json
    assert_response :forbidden
    assert_equal 'application/json', response.content_type
  end
  
  
  # testing team/requests path
  
  test "should show request as team owner" do
    get team_team_request_url(@other_team, @team_request),
      headers: { 'Authorization' => "#{User.new_token(@second_user)}" }, as: :json
    assert_response :success
    assert_equal 'application/json', response.content_type
  end

  test "should not show request to user that isn't the team owner, or the correct user" do
    get team_team_request_url(@team, @team_request),
      headers: { 'Authorization' => "#{User.new_token(@third_user)}" }, as: :json
    assert_response :forbidden
    assert_equal 'application/json', response.content_type
    assert_equal "{}", response.body
  end

  test "should not show request with empty authorization header" do
    get team_team_request_url(@other_team, @team_request),
      headers: { 'Authorization' => "" }, as: :json
    assert_response :forbidden
    assert_equal 'application/json', response.content_type
  end

  test "should not show request without authorization header" do
    get team_team_request_url(@other_team, @team_request), as: :json
    assert_response :forbidden
    assert_equal 'application/json', response.content_type
  end
end
