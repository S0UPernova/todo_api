require "test_helper"

class TasksIndexTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @second_user= users(:archer)
    @project = projects(:team_one_project_one)
    @other_teams_project = projects(:team_two_project_one)
    @team = teams(:team_one)
    @other_team = teams(:team_two)
  end

  test "should get index" do
    get team_project_tasks_url(@team, @project),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
    assert_response :success
  end

  test "should not get tasks index with incorrect authorization header" do
    get team_project_tasks_url(@team, @project),
      headers: { 'Authorization' => "#{User.new_token(@second_user)}" }, as: :json
    assert_response :forbidden
  end

  test "should not get index without authorization header" do
    get team_project_tasks_url(@team, @project), as: :json
    assert_response :forbidden
  end

  test "should not get index with empty authorization header" do
    get team_project_tasks_url(@team, @project),
      headers: { 'Authorization' => "" }, as: :json
    assert_response :forbidden
  end

  test "should not get index with empty authorization label for token" do
    get team_project_tasks_url(@team, @project),
      headers: { '' => "#{User.new_token(@first_user)}" }, as: :json
    assert_response :forbidden
  end
end
