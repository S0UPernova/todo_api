class UserMailer < ApplicationMailer
  # default from: 'notifications@example.com'
  
  def welcome_email
    @user = params[:user]
    @url = "http://#{ENV['DOMAIN']}/login"
    mail(to: @user.email, subject: 'Welcome to my todo app')
  end
end
