require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test 'no name' do
    i = Item.new
    i.errors.messages
    assert i.valid?
  end
  test 'no category' do
    i = Item.new
    assert !i.valid?
#    assert !i.errors.valid?(:category_id)
  end
#  test 'correct item' do
#    i = Item.new
#    i.price = 123
#    i.name = "pangy"
#    i.category_id = categories('one')
#    assert i.valid?
#  end
end
