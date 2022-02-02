require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @project = projects(:team_one_project_one)
    @team = teams(:team_one)
  end

  # test "should get index" do
  #   get team_projects_url(@team), headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
  #   assert_response :success
  # end

  # test "should create project" do
  #   assert_difference('Project.count') do
  #     post team_projects_url(@team), headers: { 'Authorization' => "#{User.new_token(@first_user)}" },
  #     params: { project: { description: @project.description, name: @project.name,
  #       requirements: @project.requirements, team_id: @project.team_id } }, as: :json
  #   end

  #   assert_response 201
  # end

  test "should show project" do
    get team_project_url(@team, @project), headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
    assert_response :success
  end

  # test "should update project" do
  #   patch team_project_url(@team, @project), headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, params: { project: { description: @project.description, name: @project.name, requirements: @project.requirements, team_id: @project.team_id } }, as: :json
  #   assert_response 200
  # end

  # test "should destroy project" do
  #   assert_difference('Project.count', -1) do
  #     delete team_project_url(@team, @project), headers: { 'Authorization' => "#{User.new_token(@first_user)}" }, as: :json
  #   end

  #   assert_response 204
  # end
end
