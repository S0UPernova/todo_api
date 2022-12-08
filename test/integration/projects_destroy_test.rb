require "test_helper"

class ProjectsDestroyTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @other_user = users(:archer)
    @project = projects(:team_one_project_one)
    @team = teams(:team_one)
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete team_project_url(@team, @project),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
    end
    assert_response :no_content
  end
  
  test "deleting team should destroy tasks for the project" do
    assert_difference('Task.count', -2) do
      delete team_project_url(@team, @project),
        headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
      assert_response :success
    end
  end

  test "should not destroy project without authorization header" do
    assert_no_difference('Project.count', -1) do
      delete team_project_url(@team, @project)
    end
  
    assert_response :forbidden
  end

  test "should not destroy project with empty authorization header" do
    assert_no_difference('Project.count', -1) do
      delete team_project_url(@team, @project),
        headers: { 'Authorization' => "" }, as: :json
    end
  
    assert_response :forbidden
  end

  test "should not destroy project with incorrect authorization header" do
    assert_no_difference('Project.count', -1) do
      delete team_project_url(@team, @project),
        headers: { 'Authorization' => "#{User.new_token(@other_user)}" }, as: :json
    end
  
    assert_response :forbidden
  end
end
