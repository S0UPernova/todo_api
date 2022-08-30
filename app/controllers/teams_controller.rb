class TeamsController < ApplicationController
  # before_action :correct_user,   only: [:update, :destroy]
  def index
    if params[:user_id]
      render json: current_user.teams
    else
      render json: Team.all
    end
  end
  
  def discover
    render json: Team.where.not(user_id: current_user.id).excluding(current_user.memberships)
  end

  def show
    team = Team.find(params[:id])
    render json: team
  end

  def create
    if current_user
      @team = current_user.teams.build(team_params)
      if @team.save
        render json: @team, status: :created
      else
        render json: @team.errors, status: :unprocessable_entity
      end
    else
      head :forbidden
    end
  end

  def update
    team = Team.find(params[:id])
    if correct_user
      if team.update(team_params)
        render json: team
      else
        render json: team.errors, status: :unprocessable_entity
      end
    else
      head :forbidden
    end
  end

  def destroy
    if correct_user
      @team.destroy
      render json: params, status: :no_content
    else
      head :forbidden
    end
  end

  private
    def team_params
      params.require(:team).permit(:name, :description)
    end

    def correct_user
      begin
        @team = Team.find(params[:id])
        return false unless @team.id
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
