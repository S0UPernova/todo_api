require "test_helper"

class TasksShowTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @second_user= users(:archer)
    @project = projects(:team_one_project_one)
    @team = teams(:team_one)
    @task = tasks(:team_one_task_one)
  end

  test "should show task" do
    get team_project_task_url(@team, @project, @task),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
    assert_response :success
  end

  test "should not show task without authorization header" do
    get team_project_task_url(@team, @project, @task), as: :json
    assert_response :forbidden
  end

  test "should not show task with empty authorization header" do
    get team_project_task_url(@team, @project, @task),
      headers: { 'Authorization' => "" }, as: :json
    assert_response :forbidden
  end

  test "should not show task with incorrect authorization header" do
    get team_project_task_url(@team, @project, @task),
      headers: { 'Authorization' => "#{User.new_token(@second_user)}" }, as: :json
    assert_response :forbidden
  end
end
