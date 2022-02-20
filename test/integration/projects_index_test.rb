require "test_helper"

class ProjectsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @team = teams(:team_one)
    @second_user = users(:archer)
    @project = projects(:team_one_project_one)
  end

  test "should get projects index" do
    get team_projects_url(@team),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
    assert_response :success
  end
  
  test "should not get projects index to users that are not in the team" do
    get team_projects_path(@team),
      headers: { 'Authorization' => "#{User.new_token(@second_user)}" }
    assert_response :forbidden
  end

  test "should not get projects index with incorrect authorization header" do
    get team_projects_path(@team)
    assert_response :forbidden
  end

  test "should not get projects index with empty authorization header" do
    get team_projects_path(@team),
      headers: { 'Authorization' => "" }
    assert_response :forbidden
  end

  test "should not get projects index with empty authorization label for token" do
    get team_projects_path(@team),
      headers: { '' => "#{User.new_token(@first_user)}"}
    assert_response :forbidden
  end
end
