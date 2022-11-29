require "test_helper"
class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should update a user" do
    assert @user.handle == "Mike"
      patch user_path(@user),
      headers: { 'Authorization' => "#{User.new_token(@user)}" },
      params: { 
        user: {
          handle: 'fistUser'
        } 
      }, as: :json

    assert @user.reload.handle == "fistUser"
    assert_response :success
  end

  test "should not update a user without authorization token" do
    assert @user.handle == "Mike"
      patch user_path(@user), params: { 
        user: {
          handle: 'fistUser'
        } 
      }, as: :json

    assert @user.reload.handle == "Mike"
    assert_response :forbidden
  end

  test "should not update a user with expired token" do
    assert @user.handle == "Mike"
    patch user_path(@user),
      headers: { 'Authorization' => "#{get_new_token(@user, -8400)}"},
      params: { 
        user: {
          handle: 'fistUser'
        } 
      }, as: :json
    assert @user.reload.handle == "Mike"
    assert_response :forbidden
  end

  test "should not update a user with wrong authorization token" do
    assert @user.handle == "Mike"
      patch user_path(@user),
        headers: { 'Authorization' => "#{User.new_token(@other_user)}" },
        params: { 
          
            handle: 'fistUser'
          
        }, as: :json

    assert @user.reload.handle == "Mike"
    assert_response :forbidden
  end

  test "should update a users password with password_confirmation and current_password" do
    assert @user.authenticate('password')
      patch user_path(@user),
      headers: { 'Authorization' => "#{User.new_token(@user)}" },
      params: { 
        user: {
          password: 'newPassword',
          password_confirmation: 'newPassword',
          current_password: 'password'
        } 
      }, as: :json

    assert_not @user.reload.authenticate('password')
    assert @user.reload.authenticate('newPassword')
    assert_response :success
  end

  test "should not update a users password without current_password" do
    assert @user.authenticate('password')
      patch user_path(@user),
      headers: { 'Authorization' => "#{User.new_token(@user)}" },
      params: { 
        user: {
          password: 'newPassword',
          password_confirmation: 'newPassword'
        } 
      }, as: :json

    assert @user.reload.authenticate('password')
    assert_not @user.reload.authenticate('newPassword')
    assert_response :unauthorized
  end

  test "should not update a users password without password_confirmation" do
    assert @user.authenticate('password')
      patch user_path(@user),
      headers: { 'Authorization' => "#{User.new_token(@user)}" },
      params: { 
        user: {
          password: 'newPassword',
          current_password: 'password'
        } 
      }, as: :json

    assert @user.reload.authenticate('password')
    assert_not @user.reload.authenticate('newPassword')
    assert_response :unauthorized
  end

  test "should not update a users password without password" do
    assert @user.authenticate('password')
      patch user_path(@user),
      headers: { 'Authorization' => "#{User.new_token(@user)}" },
      params: { 
        user: {
          password_confirmation: 'newPassword',
          current_password: 'password'
        } 
      }, as: :json

    assert @user.reload.authenticate('password')
    assert_not @user.reload.authenticate('newPassword')
    assert_response :unauthorized
  end
  
end
