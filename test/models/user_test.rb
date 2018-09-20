require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'create user instance' do
    u = User.new
    assert !u.valid?
  end

end
