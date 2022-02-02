require "test_helper"

class ProjectsEditTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @second_user= users(:archer)
    @project = projects(:team_one_project_one)
    @other_teams_project = projects(:team_two_project_one)
    @team = teams(:team_one)
  end

  test "should update project" do
    patch team_project_url(@team, @project), headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, params: { project: { description: @project.description, name: @project.name, requirements: @project.requirements, team_id: @project.team_id } }, as: :json
    assert_response 200
  end

  test "project name should be unique to team" do
    assert @project.name = "project_one"
    patch team_project_url(@team, @project), headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
    params: { project: { description: @project.description, name: "project_two"} }, as: :json
    assert @project.reload.name = "project_one"
    assert_response :unprocessable_entity

    patch team_project_url(@team, @project), headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
    params: { project: { description: @project.description, name: @other_teams_project.name} }, as: :json
    assert @project.reload.name = "project_two"
    assert_response :success
  end
  
  test "should not edit without authorization header" do
    patch team_project_url(@team, @project),
    params: { project: { description: @project.description, name: 'projected'} }, as: :json
    assert @project.reload.name = "projected"
    assert_response :forbidden
  end

  test "should not edit with incorrect token" do
    patch team_project_url(@team, @project), headers: { 'Authorization' => "#{User.new_token(@second_user)}" },
    params: { project: { description: @project.description, name: 'projected'} }, as: :json
    assert @project.reload.name = "projected"
    assert_response :forbidden
  end
end
