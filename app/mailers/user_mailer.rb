class UserMailer < ApplicationMailer
  # default from: 'notifications@example.com'
  helper MailerHelper
  def welcome_email(user)
    @user = user
    @url = "http://#{ENV['DOMAIN']}/login"
    mail(to: @user.email, subject: 'Welcome to my todo app')
  end
  
  def account_activation(user)
    @user = user
    mail to: @user.email, subject: 'Account activation'
  end

  def password_reset(user)
    @user = user
    mail to: @user.email, subject: 'Password reset'
  end
end
