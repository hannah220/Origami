require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { last_name: "aa", first_name: "bb", email: "user@example.com", address: "aachen", password: "password", password_confirmation: "password" }}
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
