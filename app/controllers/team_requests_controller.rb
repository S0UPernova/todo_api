class TeamRequestsController < ApplicationController
  before_action :set_team
  before_action :set_user
  before_action :set_team_request, only: [:show, :destroy, :accept, :reject]

  def index
    if @user == current_user
      render json: @user.requests
    elsif @team && @team.user_id == current_user.id
      render json: @team.requests
    else
      head :forbidden
    end
  end

  def show
      if @team && @team.requests.includes(@team_request)\
        && !@user\
        && @team.user_id == current_user.id

        render json: @team_request
      elsif @user && @user.requests.includes(@team_request)\
        && @user.id == current_user.id

        render json: @team_request
      else
        render json: @team_request.errors, status: :forbidden
      end
  end

  def create
    # @user refers to the path taken being to the user
    # @team refers to the path taken being to the team, and the input param
    # team_id which is required when creating a request to a user from a team,
    # and the user sending it for the team must be the owner
    #? might make it so admins can too, but idk
    if @team && !@user && @team.user_id != current_user.id
      @team_request = TeamRequest.new(
        user_id: current_user.id,
        team_id: @team.id,
        from_team: false
      )
    elsif @user && @user.id != current_user.id
      if @team.user_id == current_user.id 
        @team_request = TeamRequest.new(
          user_id: @user.id,
          team_id: @team.id,
          from_team: true
        )  
      end
    else
      head :forbidden
    end
    if @team_request
      if @team_request.save
        render json: @team_request, status: :created, location: @team_request_path
      else
        render json: @team_request.errors, status: :unprocessable_entity
      end
    end
    # head :unprocessable_entity
  end

  #* using the create method on teams_relationships, because if I create the
  #* relationship here than the location will be requests/members,
  #* and the teams_relationships controller should handle their creation anyway.
  #* I intend to streamline this at some point, but I am not sure how yet.
  def accept
    # @team, and @user refer to the params from the path taken
    if @team\
      && @team.requests.includes(@team_request)\
      && !@user\
      && @team.user_id == current_user.id\
      && @team_request.from_team == false\
      && @team_request.team_id == @team.id\
      || @user\
      && @user.requests.includes(@team_request)\
      && @user.id == current_user.id\
      && @team_request.from_team == true

      @team_request.update!(accepted: true)
      @create_new_relationship = TeamsRelationshipsController.new
      @create_new_relationship.create(@team_request)
      @relationship = TeamsRelationship.find_by(user_id: @team_request.user_id)
      if @relationship
        render json: {'relationship': @relationship},
        status: :created,
        location: team_teams_relationship_url(@team_request.user_id, @relationship)
      else
        render :unprocessable_entity
      end
    else
      render json: @team_request.errors, status: :forbidden
    end
  end

  def reject
    if @team\
      && @team.requests.includes(@team_request)\
      && !@user\
      && @team.user_id == current_user.id\
      && @team_request.from_team == false\
      && @team_request.team_id == @team.id\
      || @user\
      && @user.requests.includes(@team_request)\
      && @user.id == current_user.id\
      && @team_request.from_team == true
      
      @team_request.update!(accepted: false)
      render json: @team_request
    else
      head :forbidden
    end



    # if @user && @team_request.from_team == true\
    #     || @team && @team_request.from_team == false 

    #   @team_request.update(accepted: false)
    #   render json: @team_request
    # end
  end

  def destroy
    # todo add is @user == current_user and team.admins.includes current_user
    # if @user && @team_request.from_team == false\
    #     && @team_request.user_id == current_user.id\
    #     # || @team && @team_request.from_team == true\
    #     # && @team.user_id == current_user.id

    #   @team_request.destroy
    # else
    #   render :forbidden
    # end

    if @team\
      && @team.requests.includes(@team_request)\
      && !@user\
      && @team.user_id == current_user.id\
      && @team_request.from_team == true

      @team_request.destroy
    elsif @user\
      && @user.requests.includes(@team_request)\
      && @user.id == current_user.id\
      && @team_request.from_team == false
      
      @team_request.destroy
    else
      head :forbidden
    end
  end

  private
    # sets team if url for team to requests is used
    def set_team
      if params[:team_id]
        @team = Team.find(params[:team_id])
      end
    end

    # sets user if url for user to requests is used
    def set_user
      if params[:user_id]
        @user = User.find(params[:user_id])
      end
    end
    
    def set_team_request
      if params[:team_request_id]
        @team_request = TeamRequest.find(params[:team_request_id])
      else
         @team_request = TeamRequest.find(params[:id])
      end
    end
end
