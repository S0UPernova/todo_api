class AccountActivationsController < ApplicationController
  skip_before_action :require_jwt
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      render json: user, status: :accepted, location: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end
end
