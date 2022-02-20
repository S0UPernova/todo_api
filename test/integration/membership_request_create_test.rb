require "test_helper"

class MembershipRequestTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @second_user = users(:archer)
    @first_team = teams(:team_one)
    @third_team = teams(:team_three)
  end
  
  # create a new membership request to a user
  
  test "should create a new request to a user" do
    assert_difference "TeamRequest.count", 1 do
      post user_team_requests_path(@first_user),
        headers: { 'Authorization' => "#{User.new_token(@second_user)}" },
        params: {team_id: @third_team.id}
    end
    assert_response :success
  end

  test "should not create a request a for a team that you don't own" do
    assert_no_difference "TeamRequest.count" do
      post user_team_requests_path(@first_user),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
        params: {team_id: @third_team.id}
    end
    assert_response :forbidden
  end

  test "should not create a new request to a user without authorization header" do
    assert_no_difference "TeamRequest.count" do
      post user_team_requests_path(@first_user),
        params: {team_id: @third_team.id}
    end
    assert_response :forbidden
  end

  test "should not create a new request to a user with an empty authorization header" do
    assert_no_difference "TeamRequest.count" do
      post user_team_requests_path(@first_user),
        headers: { 'Authorization' => "" },
        params: {team_id: @third_team.id}
    end
    assert_response :forbidden
  end


  # create a new membership request to a team
  
  test "should create a new request to a team" do
    assert_difference "TeamRequest.count", 1 do
      post team_team_requests_path(@third_team),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
    end
    assert_response :success
  end

  test "should not create a new request your own team" do
    assert_no_difference "TeamRequest.count" do
      post team_team_requests_path(@first_team),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
    end
    assert_response :forbidden
  end

  test "should not create a new request without an authorization header" do
    assert_no_difference "TeamRequest.count" do
      post team_team_requests_path(@first_team)
    end
    assert_response :forbidden
  end

  test "should not create a new request with an empty authorization header" do
    assert_no_difference "TeamRequest.count" do
      post team_team_requests_path(@first_team),
        headers: { 'Authorization' => "" }
    end
    assert_response :forbidden
  end
end
