class UsersController < ApplicationController
  include ApplicationHelper
  # TODO add serializers/representers
  before_action :correct_user,   only: [:edit, :update, :destroy]
  before_action :require_jwt, only: [:index, :edit, :update, :destroy]

  def index  
    render json: User.all
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created, location: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])
    if correct_user
      if user.update(user_params)
        render json: user
      else
        render json: user.errors, status: :unprocessable_entity
      end
    else
      head :forbidden
    end
  end

  def destroy
    User.find(params[:id]).destroy
    render status: :no_content
  end

  private

    def user_params
      params.require(:user).permit(:handle, :name, :email, :password, :password_confirmation, :Authorization)
    end
    # TODO add logic for cookies
    def correct_user
      begin
        user = User.find(params[:id])
        token = request.headers["Authorization"]
        token_id = decode_token(token)[0]["data"]["user_id"]
        return false unless user.id
        return false unless token_id
        if user.id == token_id
          return true
        else
          head :forbidden
          return false
        end
      rescue JWT::DecodeError
        Rails.logger.warn "Error decoding the JWT: "
      end
      head :forbidden
      false
    end
    

end
