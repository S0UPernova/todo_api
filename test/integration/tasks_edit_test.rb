require "test_helper"

class TasksEditTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @second_user = users(:archer)
    @third_user = users(:trey)
    @team = teams(:team_one)
    @team_two = teams(:team_two)
    @project = projects(:team_one_project_one)
    @team_two_project_one = projects(:team_two_project_one)
    @task = tasks(:team_one_task_one)
    @team_two_task = tasks(:team_two_task_one)
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
      params: { task: { name: @team_two_project_one.name } }, as: :json
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

  test "members should update task" do
    patch team_project_task_url(@team_two, @team_two_project_one, @team_two_task),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
      params: { task: { name: "task" } }, as: :json
    assert_response :success
  end

  test "non members should not update task" do
    patch team_project_task_url(@team_two, @team_two_project_one, @team_two_task),
      headers: { 'Authorization' => "#{User.new_token(@third_user)}" },
      params: { task: { name: "task" } }, as: :json
    assert_response :forbidden
  end
end
