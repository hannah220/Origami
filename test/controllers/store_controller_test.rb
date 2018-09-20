require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
  end

  test "should get items" do
    get store_items_url
    assert_response :success
  end

  test "should get item" do
    get store_item_url
    assert_response :success
  end

end
