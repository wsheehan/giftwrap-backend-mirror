require 'rails_helper'
require 'spec_helper'

RSpec.describe "/forms/gifts API", type: :request do
  describe "gifts#create" do
    context "when client does not exist" do
      let(:params) do
        { "forms/gift": {
            "client_id": "405"
          }
        }
      end

      subject { post "/api/v1/forms/gifts",  params: params }

      it "raises RecordNotFound error" do
        subject
        expect(json['error']).to be_truthy
      end
    end

    context "when client exists" do
      context "when donor_id present" do
        before do
          @client = FactoryGirl.create :client
          @donor = FactoryGirl.create :donor
        end

        context "when gift params are incomplete" do
          subject do
            post "/api/v1/forms/gifts",
            params: { "forms/gift": {
                "client_id": @client.id,
                "donor_id": @donor.id
              }
            }
          end

          it "raises error" do
            expect{ subject }.not_to change{
              Gift.count
            }
          end
        end

        context "when gift params are complete" do
          before do
            allow(BraintreeService).to receive(:call).and_return(BraintreeHelper::SuccessResult)
          end

          subject do
            post "/api/v1/forms/gifts",
            params: { "forms/gift": {
                "client_id": @client.id,
                "donor_id": @donor.id,
                "total": '10'
              }
            }
          end

          it "creates gift" do
            expect{ subject }.to change{
              Gift.count
            }.by 1
          end
        end
      end

      context ""
    end
  end



  # describe "gifts#create" do
  #   let!(:client) { create(:client) }
  #   let!(:client_with_donors) { create(:client_with_donors) }
  #   let!(:form_conversion) { create(:metric_form_conversion) }
  #   let!(:donor) { client_with_donors.donors.first }

  #   context "when donor info is invalid" do
  #     before do
  #       result = BraintreeResult.new(false)
  #       allow(BraintreeService).to receive(:call).and_return(result)
  #     end

  #     let(:params) do
  #       { "forms/gift": {
  #           "client_id": client.id,
  #           "first_name": "Will",
  #           "total": "10",
  #           "gift_type": "gift",
  #           "payment_method_nonce": "fake-valid-nonce",
  #           "form_conversion_id": form_conversion.id
  #         }
  #       }
  #     end

  #     subject { post "/api/v1/forms/gifts", params: params }

  #     it "invalid donor info" do
  #       subject
  #       expect(response).to have_http_status 400
  #       expect(json['errors'].length).to eq 1
  #     end
  #   end

  #   context "when no donor or payment info" do
  #     before do
  #       result = BraintreeResult.new(true)
  #       allow(BraintreeService).to receive(:call).and_return(result)
  #     end

  #     let(:params) {{
  #       "forms/gift": {
  #         "client_id": client.id,
  #         "first_name": "Will",
  #         "last_name": "Sheehan",
  #         "email": "will@sheehan.com",
  #         "phone_number": "6034430335",
  #         "total": "20",
  #         "gift_type": "gift",
  #         "payment_method_nonce": "fake-valid-nonce",
  #         "form_conversion_id": form_conversion.id
  #       }
  #     }}

  #     subject { post "/api/v1/forms/gifts", params: params }

  #     it "no donor and no payment info" do
  #       subject
  #       expect(response).to be_success
  #     end
  #   end


  #   it "donor with payment info" do
  #     # generate braintree customer
  #     result = Braintree::Transaction.sale(
  #       amount: "40",
  #       payment_method_nonce: "fake-valid-nonce",
  #       options: {
  #         store_in_vault: true
  #       }
  #     )
  #     braintree_customer_id = result.transaction.customer_details.id if result.success?
  #     donor_with_payment_info = client_with_donors.donors.last
  #     donor_with_payment_info.update_attributes(braintree_customer_id: braintree_customer_id)

  #     params = {
  #       "forms/gift": {
  #         "client_id": client_with_donors.id,
  #         "donor_id": donor_with_payment_info.id,
  #         "total": "50",
  #         "gift_type": "gift",
  #         "payment_method_nonce": "fake-valid-nonce",
  #         "form_conversion_id": form_conversion.id
  #       }
  #     }
  #     post "/api/v1/forms/gifts", params: params
  #     expect(response).to be_success
  #   end

  #   it "donor but no id" do
  #     params = {
  #       "forms/gift": {
  #         "client_id": client_with_donors.id,
  #         "email": donor.email,
  #         "total": "60",
  #         "gift_type": "gift",
  #         "payment_method_nonce": "fake-valid-nonce",
  #         "form_conversion_id": form_conversion.id
  #       }
  #     }
  #     post "/api/v1/forms/gifts", params: params
  #     expect(response).to be_success
  #   end

  #   it "invalid nonce" do
  #     params = {
  #       "forms/gift": {
  #         "client_id": client_with_donors.id,
  #         "donor_id": donor.id,
  #         "total": "70",
  #         "gift_type": "gift",
  #         "payment_method_nonce": "",
  #         "form_conversion_id": form_conversion.id
  #       }
  #     }
  #     post "/api/v1/forms/gifts", params: params
  #     expect(response.status).to eq(400)
  #     expect(JSON.parse(response.body)['errors'].length).to eq 1
  #   end

  #   it "invalid gift" do
  #     params = {
  #       "forms/gift": {
  #         "client_id": client_with_donors.id,
  #         "donor_id": donor.id,
  #         "total": "",
  #         "gift_type": "gift",
  #         "payment_method_nonce": "fake-valid-nonce",
  #         "form_conversion_id": form_conversion.id
  #       }
  #     }
  #     post "/api/v1/forms/gifts", params: params
  #     expect(response.status).to eq(400)
  #     expect(JSON.parse(response.body)["errors"].length).to eq 1 
  #   end
  # end
end
