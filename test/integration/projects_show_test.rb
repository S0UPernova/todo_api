require "test_helper"

class ProjectsShowTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @other_user = users(:archer)
    @project = projects(:team_one_project_one)
    @team = teams(:team_one)
  end

  test "should show project" do
    get team_project_url(@team, @project), headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
  
    assert_response :success
  end

  test "should not show project without authorization header" do
      get team_project_url(@team, @project)
  
    assert_response :forbidden
  end

  test "should not show project with empty authorization header" do
    get team_project_url(@team, @project), headers: { 'Authorization' => "" }, as: :json
  
    assert_response :forbidden
  end

  test "should not show project with incorrect authorization header" do
    get team_project_url(@team, @project), headers: { 'Authorization' => "#{User.new_token(@other_user)}" }, as: :json
  
    assert_response :forbidden
  end
end
