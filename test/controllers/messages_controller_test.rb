require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get messages_list_url
    assert_response :success
  end

  test "should get show" do
    get messages_show_url
    assert_response :success
  end

end
