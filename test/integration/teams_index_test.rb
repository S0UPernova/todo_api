require "test_helper"

class TeamsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @first_user = users(:michael)
    @second_user = users(:archer)
  end
  
  test "should show team" do
    get teams_path,
    headers: { 'Authorization' => "#{User.new_token(@first_user)}" }
    assert_response :success
  end
  
  test "should show teams index to other users" do
    get teams_path,
    headers: { 'Authorization' => "#{User.new_token(@second_user)}" }
    assert_response :success
  end

  test "should not show teams index without authorization header" do
    get teams_path
    assert_response :forbidden
  end

  test "should not show teams index will empty authorization header" do
    get teams_path,
    headers: { 'Authorization' => "" }
    assert_response :forbidden
  end

  test "should not show teams index with empty authorization label for token" do
    get teams_path,
    headers: { '' => "#{User.new_token(@first_user)}"}
    assert_response :forbidden
  end
end
