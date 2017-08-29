require 'test_helper'

class DebugControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get debug_index_url
    assert_response :success
  end

end
