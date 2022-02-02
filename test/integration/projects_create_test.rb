require "test_helper"

class ProjectsCreateTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @second_user = users(:archer)
    @project = projects(:team_one_project_one)
    @other_teams_project = projects(:team_two_project_one)
    @team = teams(:team_one)
  end
  
  test "should create project" do
    assert_difference('Project.count') do
      post team_projects_url(@team), headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
      params: { project: { description: @project.description, name: 'project name'} }, as: :json
    end

    assert_response :created
  end

  test "project name should be unique to team" do
    assert_no_difference('Project.count') do
      post team_projects_url(@team), headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
      params: { project: { description: @project.description, name: @project.name,
        requirements: @project.requirements, team_id: @project.team_id } }, as: :json
    end

    assert_difference('Project.count') do
      post team_projects_url(@team), headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
      params: { project: { description: @project.description, name: @other_teams_project.name,
        requirements: @project.requirements, team_id: @project.team_id } }, as: :json
    end

    assert_response :created
  end

  test "should not create project without authorization header" do
    assert_no_difference('Project.count') do
      post team_projects_url(@team),
      params: { project: { description: @project.description, name: @project.name,
        requirements: @project.requirements, team_id: @project.team_id } }, as: :json
    end

    assert_response :forbidden
  end

  test "should not create project with incorrect token" do
    assert_no_difference('Project.count') do
      post team_projects_url(@team), headers: { 'Authorization' => "#{User.new_token(@second_user)}" },
      params: { project: { description: @project.description, name: @project.name,
        requirements: @project.requirements, team_id: @project.team_id } }, as: :json
    end

    assert_response :forbidden
  end
end
