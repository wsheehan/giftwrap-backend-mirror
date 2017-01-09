require 'rails_helper'
require 'spec_helper'

RSpec.describe "/donors API", type: :request do
  describe "donors#index" do
    let!(:client) { create(:client) }
    let!(:client_with_users_and_donors) { create(:client_with_users_and_donors, donors_count: 25) }

    it 'paginated index' do
      params = {
        'page': {
          'number': 1,
          'size': 10
        }
      }
      get_with_token '/api/v1/donors', params, {}, client_with_users_and_donors.users.first
      expect(response).to be_success
      expect(json["donors"].length).to eq(10)
    end

    it 'donor search results' do
      donor = client_with_users_and_donors.donors.first
      get_with_token "/api/v1/donors?q=#{donor.email}", {}, {}, client_with_users_and_donors.users.first
      expect(response).to be_success
      expect(json["donors"][0]["first_name"]).to eq(donor.first_name)
    end
  end
end
