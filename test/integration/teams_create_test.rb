require "test_helper"

class TeamsCreateTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @first_team = teams(:team_one)
    @second_user = users(:archer)
  end
  
  test "should create a team" do
    post teams_path,
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
      params: {
        team: {
          name: "team",
          description: 'description'
        }
      }
      assert_response :created
  end

  test "should not create team without authorization header" do
    post teams_path,
      params: {
        team: {
          name: "team",
          description: 'description'
        }
      }
    assert_response :forbidden
  end

  test "should not create team will empty authorization header" do
    post teams_path,
      headers: { 'Authorization' => "" },
      params: {
        team: {
          name: "team",
          description: 'description'
        }
      }
    assert_response :forbidden
  end

  test "should not create team with empty authorization label for token" do
    post teams_path,
      headers: { '' => "#{User.new_token(@first_user)}"},
      params: {
        team: {
          name: "team",
          description: 'description'
        }
      }
    assert_response :forbidden
  end
end
