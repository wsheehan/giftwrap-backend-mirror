require 'rails_helper'
require 'spec_helper'

RSpec.describe "/forms API", type: :request do
  describe "forms#show" do

    let!(:client) { create(:client) }
    let!(:client_with_form) { create(:client_with_form) }
    let!(:donor) { create(:client_with_donors).donors.first }

    it 'form without donor' do
      get "/api/v1/forms/#{client_with_form.id}"
      expect(response).to be_success # Expect :200
      expect(json['form']['metrics/forms/conversion']).to be_truthy # Expect Conversion to be created
    end

    it 'form with donor' do
      get "/api/v1/forms/#{client_with_form.id}?k=#{donor.key}"
      expect(response).to be_success # Expect :200
      expect(json['form']['donor']['id']).to eql(donor.id) # Correct donor being sent
    end

    it 'form with donor & campaign' do
      campaign = create_list(:campaign, 1, client: client_with_form)[0]
      campaign_conversion = create_list(:metric_campaign_conversion, 1, donor: donor, campaign: campaign)[0]

      get "/api/v1/forms/#{client_with_form.id}?k=#{donor.key}&ca=#{campaign.id}"
      expect(response).to be_success
    end

    it 'client does not have form' do
      get "/api/v1/forms/#{client.id}"
      expect(response).to have_http_status(404)
    end
  end
end
