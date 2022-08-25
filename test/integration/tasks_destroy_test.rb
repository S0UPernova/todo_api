require "test_helper"

class TasksDestroyTest < ActionDispatch::IntegrationTest
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

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete team_project_task_path(@team, @project, @task),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
    end

    assert_response :no_content
  end

  test "should not destroy task without authorization header" do
    assert_no_difference('Task.count', -1) do
      delete team_project_task_path(@team, @project, @task), as: :json
    end

    assert_response :forbidden
  end

  test "should not destroy task with empty authorization header" do
    assert_no_difference('Task.count', -1) do
      delete team_project_task_path(@team, @project, @task),
        headers: { 'Authorization' => "" }, as: :json
    end

    assert_response :forbidden
  end

  test "should not destroy task with incorrect authorization header" do
    assert_no_difference('Task.count', -1) do
      delete team_project_task_path(@team, @project, @task),
        headers: { 'Authorization' => "#{User.new_token(@second_user)}" }, as: :json
    end

    assert_response :forbidden
  end

  test "members should destroy task" do
    assert_difference('Task.count', -1) do
      delete team_project_task_path(@team_two, @team_two_project_one, @team_two_task),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
    end

    assert_response :no_content
  end

  test "non members should not destroy task" do
    assert_no_difference('Task.count', -1) do
      delete team_project_task_path(@team_two, @team_two_project_one, @team_two_task),
        headers: { 'Authorization' => "#{User.new_token(@third_user)}" }, as: :json
    end

    assert_response :forbidden
  end
end
