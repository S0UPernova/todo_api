class TeamsRelationshipsController < ApplicationController
  before_action :set_team
  before_action :set_membership, only: [:show, :destroy]
  
  
  def index
    # @members = @team.members unless !@team
    @relationships = TeamsRelationship.where({team_id: @team.id}) unless !@team
    if @team
      if isMember
        render json: @relationships
      else
        head :forbidden
        message = {"error": "not a member"}
        response.body = message.to_json
        return
      end
    elsif params[:user_id].to_i == current_user.id
      user = User.find(params[:user_id])
      @relationships = TeamsRelationship.where({user_id: user.id})
      # render json: current_user.memberships
      render json: @relationships
    else
      render json: {"error": "you cannot view another users memberships"},
        status: :forbidden
    end
  end

  def show
    if isMember && @team.id == @membership.team_id
      render json: @membership, status: :ok
    elsif @membership.user_id == current_user.id\
          && params[:user_id].to_i == current_user.id

      render json: @membership, status: :ok
    else
      head :forbidden
      return
    end
  end
  
  #* create is not used directly, I am using the accept method from team_requests to run it.
  # later I might make a /requests/:id/accept route for this,
  # but I am not sure of the bestway to do that at the moment,
  # so this works for now, although is definitely not a best practice
  def create(team_request)
    begin
      relationship = TeamsRelationship.find_by(user_id: team_request.user_id, team_id: team_request.team_id)
      @team_relationship = TeamsRelationship.new(
        user_id: team_request.user_id,
        team_id: team_request.team_id
      )
      @team_relationship.save! unless relationship
    rescue SQLite3::ConstraintException, ActiveRecord::RecordNotUnique
      render :unprocessable_entity
    end
  end

  def destroy
    #* team is different from @team,
    #* because @team only exists for the teams path to memberships
    team = Team.find(@membership.team_id)
    if @membership.user_id == current_user.id\
       && params[:user_id].to_i == current_user.id\
       || team.user_id == current_user.id
      @membership.destroy
    else
      head :forbidden
    end
  end
  
  private
    def set_team
      if params[:team_id]
        @team = Team.find(params[:team_id])
      end
    end
    def set_membership
        @membership = TeamsRelationship.find(params[:id])
    end
end