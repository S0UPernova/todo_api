require "test_helper"

class TeamRequestsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @team_request = team_requests(:one)
    @other_team_request = team_requests(:two)
    @team = teams(:team_one)
    @other_team = teams(:team_two)
    @first_user = users(:michael)
  end

  # test "should get index" do
  #   get team_team_requests_url(@team),
  #     headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
  #   assert_response :success
  # end

  # test "should create team_request" do
  #   assert_difference('TeamRequest.count') do
  #     post team_team_requests_url(@team),
  #       headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
  #       params: { 
  #         team_request: {
  #           accepted: @team_request.accepted,
  #           from_team: @team_request.from_team,
  #           team_id: @team_request.team_id,
  #           user_id: @team_request.user_id
  #         }
  #       },
  #         as: :json
  #   end

  #   assert_response 201
  # end

  # test "should show team_request" do
  #   get team_team_request_url(@team, @other_team_request),
  #     headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
  #   assert_response :success
  # end

  # TODO move this test to requests integration tests
  # test "should accept team_request" do
  #   patch team_team_request_accept_url(@team, @other_team_request),
  #     headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
  #     params: { 
  #       team_request: {
  #         accepted: @team_request.accepted,
  #         from_team: @team_request.from_team,
  #         team_id: @team_request.team_id,
  #         user_id: @team_request.user_id
  #       }
  #     },
  #       as: :json
  #   assert_response :created
  # end

  test "should destroy team_request" do
    assert_difference('TeamRequest.count', -1) do
      delete team_team_request_url(@team, @team_request),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
    end

    assert_response 204
  end
end
