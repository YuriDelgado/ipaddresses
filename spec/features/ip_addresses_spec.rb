require 'rails_helper'

RSpec.feature "testing validation feature", :type => :feature do
  before(:each) do
    visit "/"
  end

  scenario "User visit index and can type ip_addresses" do
    fill_in :ip_list, :with => "192.168.1.2"
    click_button "submit"

    within 'ul.results' do
      expect(all('li').count).to eq(1)
      expect(page).to have_text("192.168.1.2")
    end
  end

  scenario "User visit index can type a list of addresses, and obtain the result list" do
    fill_in :ip_list, :with => "192.168.1.2, 192.168.2.4,192.168.1.3"
    click_button "submit"

    within 'ul.results' do
      expect(all('li').count).to eq(3)
    end
  end

  scenario "User visit index can type a list of valid and invalid addresses, and obtain the validated result list" do
    fill_in :ip_list, :with => "192.168.1.2, 192.168. 2.4,192.168.1.3, 255.255.255.255, 0.0.0.0, 201.1A.21.3, 201.21"
    click_button "submit"

    within 'ul.results' do
      expect(all('li').count).to eq(7)
      expect(all('li', text: 'Invalid address').count).to eq(3)
    end
  end
end
