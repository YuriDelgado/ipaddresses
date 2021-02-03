require 'rails_helper'

RSpec.describe IpAddressesController do
  describe "GET index" do
    it 'return 200 OK status' do
      get :index

      expect(response).to have_http_status(:ok)
    end
  end
end

RSpec.describe 'POSt validate', :type => :request do
  describe "POST validate" do
    context "with valid parameters" do
      let(:valid_params) do
        { ip_list: '192.168.1.2' }
      end

      it "validate must redirect to index" do
        post validate_path, params: { ip_list: '' }
        expect(response).to have_http_status(302)
        expect(response.headers['Location']).to eq root_url

        follow_redirect!
        expect(response).to have_http_status(:success)
      end
    end
  end
end
