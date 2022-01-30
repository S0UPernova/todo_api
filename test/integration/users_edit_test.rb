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
end
