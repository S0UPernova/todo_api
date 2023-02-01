require "test_helper"

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup 
    ActionMailer::Base.deliveries.clear
    @user = users(:michael)
  end

  test "post password resets" do
    # Invalid email
    post password_resets_path, params:  {email: ""}
    assert_response :unprocessable_entity
    assert_equal "{\"Error\":\"Email address not found\"}", response.body
    
    # Valid email
    post password_resets_path, params:  {email: @user.email}
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_response :ok
    assert_equal 1, ActionMailer::Base.deliveries.size

    # todo figure out how to get token to test this
    # Wrong email
  #   patch password_reset_path(@user.reset_token),
  #   params: { email: @user.email,
  #             user: { password:              "foobaz", 
  #                     password_confirmation: "barquux" } }
  # assert_response :ok
  end
end

