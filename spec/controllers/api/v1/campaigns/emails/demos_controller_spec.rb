require 'rails_helper'

RSpec.describe Api::V1::Campaigns::Emails::DemosController, type: :controller do

  describe "POST #create" do
    before do
      allow_any_instance_of(ApplicationController).to receive(:authenticated?).and_return(true)
      @user = FactoryGirl.create :user
      @donor = FactoryGirl.create :donor
    end

    subject { post :create, "campaigns/emails/demo" => { title: 'Jaba', donor_email: @donor.email, client_name: 'Great school' } }

    context "when email builds successfully" do
      it "builds an email" do
        subject
        expect(response).to have_http_status(:ok)
      end
    end

    context "when email does not build successfully" do
      before do
        allow_any_instance_of(Campaign::Email).to receive(:save).and_return(false)
      end

      it "returns error status" do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
