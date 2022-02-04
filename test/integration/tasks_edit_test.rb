require "test_helper"

class TasksEditTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @second_user= users(:archer)
    @project = projects(:team_one_project_one)
    @other_teams_project = projects(:team_two_project_one)
    @team = teams(:team_one)
    @task = tasks(:team_one_task_one)
  end

  test "should update task" do
    patch team_project_task_url(@team, @project, @task),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
      params: { task: { name: "task" } }, as: :json
    assert_response :success
  end

  test "task name should be unique to project" do
    patch team_project_task_url(@team, @project, @task),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
      params: { task: { name: @task.name } }, as: :json
    assert_response :unprocessable_entity

    patch team_project_task_url(@team, @project, @task),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
      params: { task: { name: @other_teams_project.name } }, as: :json
    assert_response :success
  end

  test "should not update task without authorization header" do
    patch team_project_task_url(@team, @project, @task),
      params: { task: { name: "task" } }, as: :json
    assert_response :forbidden
  end

  test "should not update task with incorrect token" do
    patch team_project_task_url(@team, @project, @task),
      headers: { 'Authorization' => "#{User.new_token(@second_user)}" },
      params: { task: { name: "task" } }, as: :json
    assert_response :forbidden
  end
end
