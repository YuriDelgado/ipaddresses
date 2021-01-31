require 'application_system_test_case'

class IpAddressTest < ApplicationSystemTestCase

  test "visiting root index" do
    visit root_url

    assert_selector 'input[name=ip_list]'
    assert_selector 'input[type=submit]'
    assert_selector 'ul.results'
  end

  test "testing valid ip_address" do
    visit root_url
    fill_in :ip_list, with: '192.168.1.3'
    click_button :submit

    within 'ul.results' do
      assert_selector 'li', text: '192.168.1.3'
    end
  end

  test "testing several valid ip_address" do
    visit root_url
    fill_in :ip_list, with: '192.168.1.3, 192.168.3.1, 192.168.21.4'
    click_button :submit

    within 'ul.results' do
      assert_selector 'li', text: 'Invalid address', count: 0
    end
  end

  test "testing display all elements of the list" do
    list = %w[192.168.1.2 192 420.21.31.45].join(',')
    visit root_url

    fill_in :ip_list, with: "192.168.1.2, 192, 420.21.31.45"
    click_button :submit

    assert_selector 'li', count: 3
  end

  test "testing ipaddress fromat, only numbers" do
    visit root_url
    fill_in :ip_list, with: '1f2.DES.1.3'
    click_button :submit

    within 'ul.results' do
      assert_selector 'li', text: 'Invalid address'
    end
  end

  test "testing ipaddress format, no more than 4 blocks of numbers" do
    visit root_url
    fill_in :ip_list, with: '192.168.1.2.3'
    click_button :submit

    within 'ul.results' do
      assert_selector 'li', text: 'Invalid address'
    end
  end

  test "testing ipaddress format, not less than 4 blocks of numbers" do
    visit root_url
    fill_in :ip_list, with: '192.168.1'
    click_button :submit

    within 'ul.results' do
      assert_selector 'li', text: 'Invalid address'
    end
  end

end
