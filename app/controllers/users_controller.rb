class UsersController < ApplicationController
  include ApplicationHelper
  # TODO add serializers/representers
  before_action :correct_user,   only: [:edit, :update, :destroy]
  before_action :require_jwt, only: [:index, :show, :update, :destroy]

  def index  
    render json: User.all
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      # UserMailer.account_activation(@user).deliver_now
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])
    if correct_user
      
      if user_params[:password] || user_params[:password_confirmation]
        if user_params[:password] == user_params[:password_confirmation]
          if user&.authenticate(params[:user][:current_password])
            if user.update(user_params)
              render json: user
            else
              render json: user.errors, status: :unprocessable_entity
            end
          else
            if params[:user][:current_password]
              render json: {password: 'current password you entered does not seem right'}, status: :unauthorized
            else
              render json: {password: 'current password required'}, status: :unauthorized
            end
          end
        else
          render json: {password: 'password and confirmation must match'}, status: :unauthorized
        end

      elsif !user_params[:password] && !user_params[:password_confirmation]
        if user.update(user_params)
          render json: user
        else
          render json: user.errors, status: :unprocessable_entity
        end
      else
        render json: {password: 'new password required'}, status: :unauthorized
      end

    else
      head :forbidden
    end
  end

  # todo make this require password
  def destroy
    User.find(params[:id]).destroy
    render status: :no_content
  end

  def resend_activation_email
    @user = User.find_by(email: params[:user][:email])
    if @user
      @user.resend_activation_email
      # UserMailer.account_activation(@user).deliver_now
      # render json: @user, status: :created, location: @user
    else
      render status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:handle, :name, :email, :password, :password_confirmation)
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
