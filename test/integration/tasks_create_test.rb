require "test_helper"

class TasksCreateTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @second_user= users(:archer)
    @project = projects(:team_one_project_one)
    @other_teams_project = projects(:team_two_project_one)
    @team = teams(:team_one)
    @task = tasks(:team_one_task_one)
  end

  test "should create task" do
    assert_difference('Task.count') do
      post team_project_tasks_url(@team, @project),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
      params: { task: { 
        name: "task",
        description: "task description"} }, as: :json
    end

    assert_response :created
  end

  test "task name should be unique to project" do
    assert_no_difference('Task.count') do
      post team_project_tasks_url(@team, @project),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
      params: { task: { 
        name: @task.name,
        description: "task description"} }, as: :json
    end

    assert_difference('Task.count') do
      post team_project_tasks_url(@team, @project),
      headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
      params: { task: { 
        name: @other_teams_project.name,
        description: "task description"} }, as: :json
    end

    assert_response :created
  end

  test "should not create task without authorization header" do
    assert_no_difference('Task.count') do
      post team_project_tasks_url(@team, @project),
      params: { task: { 
        name: "task",
        description: "task description"} }, as: :json
    end

    assert_response :forbidden
  end

  test "should not create task with empty authorization header" do
    assert_no_difference('Task.count') do
      post team_project_tasks_url(@team, @project),
      headers: { 'Authorization' => "" },
      params: { task: { 
        name: "task",
        description: "task description"} }, as: :json
    end

    assert_response :forbidden
  end

  test "should not create task with incorrect token" do
    assert_no_difference('Task.count') do
      post team_project_tasks_url(@team, @project),
      headers: { 'Authorization' => "#{User.new_token(@second_user)}" },
      params: { task: { 
        name: "task",
        description: "task description"} }, as: :json
    end

    assert_response :forbidden
  end
end
