require 'test_helper'

class ColorTest < ActiveSupport::TestCase
  test "create a color instance" do
    color = Color.new
    assert_not color.save
  end
end
