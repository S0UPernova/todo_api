class HomeController < ApplicationController
  # include ActionController::MimeResponds
  skip_before_action :require_jwt
  def index
    # respond_to do |format|
    #   format.html  { render :json => {docs: 'coming soon'} }
    #   # format.html  { render :json => {docs: 'coming'} }
    #   format.json  { render :json => {docs: 'coming soon'} }
    # end
    render :json => {docs: 'coming soon'}
  end
end
