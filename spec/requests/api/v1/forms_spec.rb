require 'rails_helper'
require 'spec_helper'

RSpec.describe "/forms API", type: :request do
  describe "forms#show" do
    let!(:client) { create(:client) }
    it 'form without donor' do
      get "/api/v1/forms/#{client.id}"
      expect(response).to be_success # Expect :200
      expect(json['form']['metrics/forms/conversion']).to be_truthy # Expect Conversion to be created
    end
    it 'form with donor' do
      key = create(:client_with_donors).donors.first.key
      get "/api/v1/forms/#{client.id}?k=#{key}"
      expect(response).to be_success # Expect :200
      expect(json['form']['donor']['key']).to eql(key) # Correct donor being sent
    end
  end
end
