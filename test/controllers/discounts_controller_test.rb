require "test_helper"

class DiscountsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get discounts_create_url
    assert_response :success
  end

  test "should get update" do
    get discounts_update_url
    assert_response :success
  end

  test "should get destroy" do
    get discounts_destroy_url
    assert_response :success
  end
end
