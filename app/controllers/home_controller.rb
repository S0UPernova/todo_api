class HomeController < ApplicationController
  skip_before_action :require_jwt
  def index
    render json: {docs: 'coming soon'}
  end
end
