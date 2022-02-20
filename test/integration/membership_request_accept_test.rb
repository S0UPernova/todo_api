require "test_helper"

class MembershipRequestAcceptTest < ActionDispatch::IntegrationTest
  def setup
    @third_team_request = team_requests(:three)
    @fourth_team_request = team_requests(:four)

    @second_team = teams(:team_two)
    @third_team = teams(:team_three)

    @second_user = users(:archer)
    @third_user = users(:trey)
  end

  # users request accept route
  
  test "should accept request as user if team is sender" do
    assert_difference('TeamsRelationship.count', 1) do
      patch user_team_request_accept_url(@third_user, @fourth_team_request),
        headers: { 'Authorization' => "#{User.new_token(@third_user)}" }, as: :json
    end

    assert_equal true, @fourth_team_request.reload.accepted
    assert_equal 'application/json', response.content_type
    assert_response :created
  end

  test "should not accept request as user if user is sender" do
    assert_no_difference('TeamsRelationship.count') do
      patch user_team_request_accept_url(@third_user, @third_team_request),
        headers: { 'Authorization' => "#{User.new_token(@third_user)}" }, as: :json
    end

    assert_equal 'application/json', response.content_type
    assert_response :forbidden
  end

  test "should not accept request as user if incorrect user" do
    assert_no_difference('TeamsRelationship.count') do
      patch user_team_request_accept_url(@third_user, @fourth_team_request),
        headers: { 'Authorization' => "#{User.new_token(@second_user)}" }, as: :json
    end

    assert_equal 'application/json', response.content_type
    assert_response :forbidden
  end

  test "should not accept request as user with empty authorization header" do
    assert_no_difference('TeamsRelationship.count') do
      patch user_team_request_accept_url(@third_user, @fourth_team_request),
        headers: { 'Authorization' => "" }, as: :json
    end

    assert_equal 'application/json', response.content_type
    assert_response :forbidden
  end

  test "should not accept request as user without authorization header" do
    assert_no_difference('TeamsRelationship.count') do
      patch user_team_request_accept_url(@third_user, @fourth_team_request), as: :json
    end

    assert_equal 'application/json', response.content_type
    assert_response :forbidden
  end


  # teams request accept route
  
  test "should accept request when as team if user is sender" do
    assert_difference('TeamsRelationship.count', 1) do
      patch team_team_request_accept_url(@third_team, @third_team_request),
        headers: { 'Authorization' => "#{User.new_token(@second_user)}" }, as: :json
    end

    assert_equal true, @third_team_request.reload.accepted
    assert_equal 'application/json', response.content_type
    assert_response :created
  end

  test "should not accept request when as team if incorrect team route" do
    assert_no_difference('TeamsRelationship.count') do
      patch team_team_request_accept_url(@second_team, @third_team_request),
        headers: { 'Authorization' => "#{User.new_token(@second_user)}" }, as: :json
    end

    assert_equal 'application/json', response.content_type
    assert_response :forbidden
  end

  test "should not accept request when as team if team is sender" do
    assert_no_difference('TeamsRelationship.count') do
      patch team_team_request_accept_url(@third_team, @fourth_team_request),
        headers: { 'Authorization' => "#{User.new_token(@second_user)}" }, as: :json
    end

    assert_equal 'application/json', response.content_type
    assert_response :forbidden
  end

  test "should not accept request when as team if incorrect user" do
    assert_no_difference('TeamsRelationship.count') do
      patch team_team_request_accept_url(@third_team, @third_team_request),
        headers: { 'Authorization' => "#{User.new_token(@third_user)}" }, as: :json
    end

    assert_equal 'application/json', response.content_type
    assert_response :forbidden
  end

  test "should not accept request with empty authorization header" do
    assert_no_difference('TeamsRelationship.count') do
      patch team_team_request_accept_url(@third_team, @third_team_request),
        headers: { 'Authorization' => "" }, as: :json
    end

    assert_equal 'application/json', response.content_type
    assert_response :forbidden
  end

  test "should not accept request without authorization header" do
    assert_no_difference('TeamsRelationship.count') do
      patch team_team_request_accept_url(@third_team, @third_team_request), as: :json
    end

    assert_equal 'application/json', response.content_type
    assert_response :forbidden
  end
end
