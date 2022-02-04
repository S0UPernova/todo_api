require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  # TODO make these integration tests
  def setup
    @first_user = users(:michael)
    @second_user= users(:archer)
    @project = projects(:team_one_project_one)
    @other_teams_project = projects(:team_two_project_one)
    @team = teams(:team_one)
    @task = tasks(:team_one_task_one)
  end

  # test "should get index" do
  #   get team_project_tasks_url(@team, @project),
  #     headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
  #   assert_response :success
  # end

  # test "should create task" do
  #   assert_difference('Task.count') do
  #     post team_project_tasks_url(@team, @project),
  #     headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
  #     params: { task: { 
  #       name: "task",
  #       description: "task description"} }, as: :json
  #   end

  #   assert_response 201
  # end

  # test "should show task" do
  #   get team_project_task_url(@team, @project, @task),
  #     headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
  #   assert_response :success
  # end

  # test "should update task" do
  #   patch team_project_task_url(@team, @project, @task),
  #     headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
  #     params: { task: { name: "task" } }, as: :json
  #   assert_response 200
  # end

  # test "should destroy task" do
  #   assert_difference('Task.count', -1) do
  #     delete team_project_task_path(@team, @project, @task),
  #       headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
  #   end

  #   assert_response 204
  # end
end
