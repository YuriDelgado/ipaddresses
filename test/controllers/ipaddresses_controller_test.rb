require 'test_helper'

class IpAddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "should get validate" do
    post validate_url, params: { ip_list: '' }
    assert_redirected_to root_path
  end

  test "should show validation results" do
    post validate_url, params: { ip_list: '192.168.1.2' }
    assert_includes @response.body, '192.168.1.2'
  end

  test "should include 'Invalid address' in the response with wrong address format" do
    post validate_url, params: { ip_list: '192.168.01.2, 192.168.1.3' }
    assert_includes @response.body, 'Invalid+address'
  end
end
