require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:michael)
    user.activation_token = User.random_token
    mail = UserMailer.account_activation(user)
    assert_equal "Account activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal [ENV['SENDGRID_EMAIL']], mail.from
    assert_match "Hi", mail.body.encoded
  end
  # test "password_reset" do
  #   mail = UserMailer.password_reset
  #   assert_equal "Password reset", mail.subject
  #   assert_equal [user.email], mail.to
  #   assert_equal ENV['EMAIL'], mail.from
  #   assert_match "Hi", mail.body.encoded
  # end
end
