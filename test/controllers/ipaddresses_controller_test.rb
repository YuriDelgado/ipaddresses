require 'test_helper'

class IpAddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ipaddresses_index_url
    assert_response :success
  end

  test "should get validate" do
    get ipaddresses_validate_url
    assert_response :success
  end

end
