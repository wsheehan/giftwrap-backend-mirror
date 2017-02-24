require 'rails_helper'
require 'spec_helper'

RSpec.describe "campaigns/texts API", type: :request do
  describe "texts#create" do
    before :each do
      allow_any_instance_of(ApplicationController).to receive(:authenticate_user).and_return(true)
      @client = FactoryGirl.create :client
      @donor_list = FactoryGirl.create(:donor_list, client: @client)
    end

    let(:params) do
      { "campaigns/text":
        {
          "client_id": @client.id,
          "body": "Test Campaign Body!!",
          "donor_list_id": @donor_list.id,
          "title": "Day of Giving",
          "description": "Day of Giving text campaign 2017"
        }
      }
    end

    it "good request" do
      post "/api/v1/campaigns/texts", params: params
      expect(json["campaigns/text"]).to be_truthy
    end
  end
end
