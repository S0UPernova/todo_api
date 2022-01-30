require "test_helper"

class UsersCreateTest < ActionDispatch::IntegrationTest
  test "should create a user" do
    assert_difference('User.count') do
      post users_path, params: { 
        user: {
          handle: 'firstUser',
          name: 'michael',
          email: 'exam@example.com',
          password: 'foobar',
          password_confirmation: 'foobar'
        } 
      }, as: :json
    end

    assert_response :created
  end

  test "should not create a user when password is blank" do
    assert_no_difference('User.count') do
      post users_path, params: { 
        user: {
          handle: 'secondUser',
          name: 'notMichael',
          email: 'notmichael@example.com',
          password: '',
          password_confirmation: ''
        } 
      }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should not create a user when email is blank" do
    assert_no_difference('User.count') do
      post users_path, params: { 
        user: {
          handle: 'secondUser',
          name: 'notMichael',
          email: '',
          password: 'foobar',
          password_confirmation: 'foobar'
        } 
      }, as: :json
    end

    assert_response :unprocessable_entity
  end
end
