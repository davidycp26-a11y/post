require "test_helper"

class UserMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_messages_index_url
    assert_response :success
  end
end
