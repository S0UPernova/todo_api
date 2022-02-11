class TeamsRelationshipsController < ApplicationController
  before_action :set_team
  before_action :set_members
  
  
  def index
    if isMember
      render json: @members
    else
      render json: {"error": "not a member"}, status: :forbidden
    end
  end
  
  def create
    # @user = User.find(params[:member_id])
    
    @team_relationship = TeamsRelationship.new(relationship_params)
    @task.project_id = @project.id
    if @task.save
      render json: @task, status: :created, location: team_project_task_url(@team, @project, @task)
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end
  private
    def relationship_params
      params.require(:relationship).permit(:member_id, :team_id)
    end

    def set_team
      @team = Team.find(params[:team_id])
    end

    def set_members
      @members = @team.members
    end
    
    def isMember
      if @members.include?(current_user) || @team.user_id == current_user.id
        return true
      else
        return false
      end
    end
end
