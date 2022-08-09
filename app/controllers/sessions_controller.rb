class SessionsController < ApplicationController
  skip_before_action :require_jwt
  def create
    user = User.find_by(email: params[:user][:email].downcase)
    if user&.authenticate(params[:user][:password])
      render json: {
        "token": User.new_token(user),
        "user": {
          "id": user.id,
          "handle": user.handle
        }
      }
    else
      head :unauthorized
    end
  end
end