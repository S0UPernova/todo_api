class SessionsController < ApplicationController
  # before_action :require_jwt, only: :validate_token
  def create
    user = User.find_by(email: params[:user][:email].downcase)
    if user&.authenticate(params[:user][:password])
      render json: User.new_token(user)
    end
  end
end