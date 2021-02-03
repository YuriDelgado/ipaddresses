require 'rails_helper'

RSpec.describe IpAddressesController do
  context "GET index" do
    it 'return 200 OK status' do
      get :index

      expect(response).to have_http_status(:ok)
    end
  end
end

RSpec.describe 'POST validate', :type => :request do
  context "with empty parameters" do
    it "validate must redirect to index" do
      post validate_path, params: { ip_list: '' }
      expect(response).to have_http_status(302)
      expect(response.headers['Location']).to eq root_url

      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

  context "with valid params" do
    it "validate must redirect to index" do
      post validate_path, params: { ip_list: '192.168.1.2' }
      expect(response).to have_http_status(302)

      follow_redirect!
      expect(response.body).to include('192.168.1.2')
      expect(response).to have_http_status(:success)
    end
  end

  context "with invalid ipaddresss params" do
    it "validate must redirect to index" do
      post validate_path, params: { ip_list: '192.1680.1.2' }
      expect(response).to have_http_status(302)

      follow_redirect!
      expect(response.body).to include('Invalid address')
      expect(response).to have_http_status(:success)
    end
  end
end
