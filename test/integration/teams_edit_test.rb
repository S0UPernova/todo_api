require "test_helper"

class TeamsEditTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @first_team = teams(:team_one)
    @second_user = users(:archer)
  end
  
  test "should get update" do
    patch team_path(@first_team),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
      params: { team: { name: "team", description: 'description' } }
      assert_response :success
  end

  test "should not update team with incorrect token" do
    patch team_path(@first_team),
    headers: { 'Authorization' => "#{User.new_token(@second_user)}" },
    params: { team: { name: "team", description: 'description' } }
    assert_response :forbidden
  end

  test "should not update team without authorization header" do
    patch team_path(@first_team),
    params: { team: { name: "team", description: 'description' } }
    assert_response :forbidden
  end

  test "should not update team will empty authorization header" do
    patch team_path(@first_team),
    headers: { 'Authorization' => "" },
    params: { team: { name: "team", description: 'description' } }
    assert_response :forbidden
  end

  test "should not update team with empty authorization label for token" do
    patch team_path(@first_team),
    headers: { '' => "#{User.new_token(@first_user)}"},
    params: { team: { name: "team", description: 'description' } }
    assert_response :forbidden
  end
end
