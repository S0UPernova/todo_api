require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
  
  test "should get index" do
    get users_url, headers: { 'Authorization' => "#{User.new_token(@user)}"}
    assert_response :success
  end
end
