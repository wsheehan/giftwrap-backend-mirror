require 'rails_helper'
require 'spec_helper'
require 'braintree'

RSpec.describe "/forms/gifts API", type: :request do
  describe "gifts#create" do
    let!(:client) { create(:client) }
    let!(:client_with_donors) { create(:client_with_donors) }
    let!(:form_conversion) { create(:metric_form_conversion) }
    let!(:donor) { client_with_donors.donors.first }

    it "invalid donor info" do
      params = {
        "forms/gift": {
          "client_id": client.id,
          "first_name": "Will",
          "total": "10",
          "gift_type": "gift",
          "payment_method_nonce": "fake-valid-nonce",
          "form_conversion_id": form_conversion.id
        }
      }
      post "/api/v1/forms/gifts", params: params
      expect(response.status).to eq(400)
      expect(json_err_msg).to eq("Donor Information Could Not Be Saved")
    end

    it "no donor and no payment info" do
      params = {
        "forms/gift": {
          "client_id": client.id,
          "first_name": "Will",
          "last_name": "Sheehan",
          "email": "will@sheehan.com",
          "phone_number": "6034430335",
          "total": "20",
          "gift_type": "gift",
          "payment_method_nonce": "fake-valid-nonce",
          "form_conversion_id": form_conversion.id
        }
      }
      post "/api/v1/forms/gifts", params: params
      expect(response).to be_success
    end

    it "donor and no payment info" do
      params = {
        "forms/gift": {
          "client_id": client_with_donors.id,
          "donor_id": donor.id,
          "total": "30",
          "gift_type": "gift",
          "payment_method_nonce": "fake-valid-nonce",
          "form_conversion_id": form_conversion.id
        }
      }
      post "/api/v1/forms/gifts", params: params
      expect(response).to be_success
    end

    it "donor with payment info" do
      # generate braintree customer
      result = Braintree::Transaction.sale(
        amount: "40",
        payment_method_nonce: "fake-valid-nonce",
        options: {
          store_in_vault: true
        }
      )
      braintree_customer_id = result.transaction.customer_details.id if result.success?
      donor_with_payment_info = client_with_donors.donors.last
      donor_with_payment_info.update_attributes(braintree_customer_id: braintree_customer_id)

      params = {
        "forms/gift": {
          "client_id": client_with_donors.id,
          "donor_id": donor_with_payment_info.id,
          "total": "50",
          "gift_type": "gift",
          "payment_method_nonce": "fake-valid-nonce",
          "form_conversion_id": form_conversion.id
        }
      }
      post "/api/v1/forms/gifts", params: params
      expect(response).to be_success
    end

    it "donor but no id" do
      params = {
        "forms/gift": {
          "client_id": client_with_donors.id,
          "email": donor.email,
          "total": "60",
          "gift_type": "gift",
          "payment_method_nonce": "fake-valid-nonce",
          "form_conversion_id": form_conversion.id
        }
      }
      post "/api/v1/forms/gifts", params: params
      expect(response).to be_success
    end

    it "invalid nonce" do
      params = {
        "forms/gift": {
          "client_id": client_with_donors.id,
          "donor_id": donor.id,
          "total": "70",
          "gift_type": "gift",
          "payment_method_nonce": "",
          "form_conversion_id": form_conversion.id
        }
      }
      post "/api/v1/forms/gifts", params: params
      expect(response.status).to eq(400)
      expect(json_err_msg).to eq("Payment Information Did not Process")
    end

    it "invalid gift" do
      params = {
        "forms/gift": {
          "client_id": client_with_donors.id,
          "donor_id": donor.id,
          "total": "",
          "gift_type": "gift",
          "payment_method_nonce": "fake-valid-nonce",
          "form_conversion_id": form_conversion.id
        }
      }
      post "/api/v1/forms/gifts", params: params
      expect(response.status).to eq(400)
      expect(json_err_msg).to eq("Gift Could not Save")
    end
  end
end
