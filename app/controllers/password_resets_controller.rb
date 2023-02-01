class PasswordResetsController < ApplicationController
  skip_before_action :require_jwt
  before_action :get_user,   only:       [:edit, :update]
  before_action :valid_user, only:       [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  def new
  end
  
  def create
    user = User.find_by(email: params[:email].downcase)
    if user
      user.create_reset_digest
      user.send_password_reset_email
      render json: user, status: :ok, location: user
    else 
      render json: {"Error": "Email address not found"}, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if params[:user][:password].empty?
      render json: {error: "password can't be empty"}, status: :unprocessable_entity
    elsif @user.update(user_params)
      render json: @user, status: :ok, location: @user
    else
      render json: {error: "something went wrong"}, status: :unprocessable_entity
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    # before filters

    def get_user
      @user = User.find_by(email: params[:email].downcase)
    end

    # Confirms a valid user
    def valid_user
      # ? maybe add && @user.activated?
      unless (@user && @user.authenticated?( :reset, params[:id]))
        render json: {error: "something went wrong"}, status: :unprocessable_entity
      end
    end
    
    def check_expiration
      if @user.password_reset_expired?
        render json: {error: "password reset is expired"}, status: :unauthorized
      end
    end
end
