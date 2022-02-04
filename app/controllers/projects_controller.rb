class ProjectsController < ApplicationController
  before_action :get_team
  before_action :correct_user
  before_action :set_project, only: [:show, :update, :destroy]

  def index
    @projects = @team.projects

    render json: @projects
  end

  def show
    render json: @project
  end

  def create
    @project = Project.new(project_params)
    @project.team_id = @team.id
    if @project.save
      render json: @project, status: :created, location: team_project_url(@team, @project)
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
  end

  private
    def get_team
      @team = Team.find(params[:team_id])
      raise 'error' if !@team
    end

    def set_project
      @project = @team.projects.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :requirements)
    end

    # TODO add logic for admins
    def correct_user
      begin
        return false unless @team
        return false unless current_user
        if @team.user_id == current_user.id
          return true
        else
          head :forbidden
          return false
        end
      end
      head :forbidden
      false
    end
end
