require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = users(:michael)
  end
  test "account_activation" do
    @user.activation_token = User.random_token
    mail = UserMailer.account_activation(@user)
    assert_equal "Account activation", mail.subject
    assert_equal [@user.email], mail.to
    assert_equal [ENV['SENDGRID_EMAIL']], mail.from
    assert_match @user.activation_token,  mail.body.encoded
    assert_match CGI.escape(@user.email), mail.body.encoded
  end
  test "password_reset" do
    @user.reset_token = User.random_token
    mail = UserMailer.password_reset(@user)
    assert_equal "Password reset", mail.subject
    assert_equal [@user.email], mail.to
    assert_equal [ENV['SENDGRID_EMAIL']], mail.from
    assert_match @user.reset_token,       mail.body.encoded
    assert_match CGI.escape(@user.email), mail.body.encoded
  end
end
