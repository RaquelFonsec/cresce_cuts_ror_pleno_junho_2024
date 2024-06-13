require "test_helper"

class Api::ProdutosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_produtos_index_url
    assert_response :success
  end
end
