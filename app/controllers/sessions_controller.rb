class SessionsController < ApplicationController
  skip_before_action :require_jwt
  def create
    user = User.find_by(email: params[:user][:email].downcase)
    if user&.authenticate(params[:user][:password])
      render json: User.new_token(user)
    else
      head :unauthorized
    end
  end
end