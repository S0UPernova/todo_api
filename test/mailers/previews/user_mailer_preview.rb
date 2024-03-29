# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def account_activation
    UserMailer.account_activation
    user = User.first
    user.activation_token = User.random_token
    UserMailer.account_activation(user)
    
  end

  def password_reset
    user = User.first
    user.reset_token = User.random_token
    UserMailer.password_reset(user)
  end
end
