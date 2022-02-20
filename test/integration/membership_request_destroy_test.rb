require "test_helper"

class MembershipRequestDestroyTest < ActionDispatch::IntegrationTest
  def setup
    @team_request = team_requests(:one)
    @second_team_request = team_requests(:two)
    @third_team_request = team_requests(:three)

    @first_team = teams(:team_one)
    @second_team = teams(:team_two)
    @third_team = teams(:team_three)

    @first_user = users(:michael)
    @second_user = users(:archer)
    @third_user = users(:trey)
  end


  # user requests route

  test "should destroy request as user, and sender" do
    assert_difference('TeamRequest.count', -1) do
      delete user_team_request_url(@third_user, @third_team_request),
      headers: { 'Authorization' => "#{User.new_token(@third_user)}" }, as: :json
    end
    
    assert_response :no_content
  end

  test "should not destroy request if incorrect user" do
    assert_no_difference('TeamRequest.count') do
      delete user_team_request_url(@third_user, @third_team_request),
      headers: { 'Authorization' => "#{User.new_token(@second_user)}" }, as: :json
    end
    
    assert_response :forbidden
  end

  test "user should not destroy request when user is not the sender" do
    assert_no_difference('TeamRequest.count') do
      delete user_team_request_url(@first_user, @team_request),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
    end

    assert_equal 'application/json', response.content_type
    assert_response :forbidden
  end

  test "user should not destroy request with empty authorization header" do
    assert_no_difference('TeamRequest.count') do
      delete user_team_request_url(@second_user, @team_request),
        headers: { 'Authorization' => "" }, as: :json
    end

    assert_equal 'application/json', response.content_type
    assert_response :forbidden
  end

  test "user should not destroy request without authorization header" do
    assert_no_difference('TeamRequest.count') do
      delete user_team_request_url(@second_user, @team_request), as: :json
    end

    assert_equal 'application/json', response.content_type
    assert_response :forbidden
  end


  # team requests route

  test "team should destroy request as team owner, and sender" do
    assert_difference('TeamRequest.count', -1) do
      delete team_team_request_url(@second_team, @team_request),
        headers: { 'Authorization' => "#{User.new_token(@second_user)}" }, as: :json
    end

    assert_response :no_content
  end

  test "team should not destroy request as team owner, if team is not the sender" do
    assert_no_difference('TeamRequest.count') do
      delete team_team_request_url(@third_team, @third_team_request),
        headers: { 'Authorization' => "#{User.new_token(@second_user)}" }, as: :json
    end

    assert_equal 'application/json', response.content_type
    assert_response :forbidden
  end

  test "team should not destroy request with empty authorization header" do
    assert_no_difference('TeamRequest.count') do
      delete team_team_request_url(@second_team, @team_request),
        headers: { 'Authorization' => "" }, as: :json
    end

    assert_equal 'application/json', response.content_type
    assert_response :forbidden
  end

  test "team should not destroy request without authorization header" do
    assert_no_difference('TeamRequest.count') do
      delete team_team_request_url(@second_team, @team_request), as: :json
    end

    assert_equal 'application/json', response.content_type
    assert_response :forbidden
  end
end
