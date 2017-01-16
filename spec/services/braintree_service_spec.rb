require 'rails_helper'
require 'fake_braintree'
FakeBraintree.activate!

RSpec.describe BraintreeService do

  describe "::call" do
    context "when one_time_payment" do
      before do
        @donor  = FactoryGirl.create :donor
        @params = {
          payment_method_nonce: 'fake-valid-nonce',
          total: '50.00'
        } 
      end

      subject { BraintreeService.call('create_one_time_payment', @donor, @params) }

      context "when donor has no braintree_customer_id" do
        it "creates payment" do
          expect(subject.success?).to be true
        end
      end

      context "when donor has braintree_customer_id" do
        before do
          braintree_user = Braintree::Customer.create(
            first_name: @donor.first_name,
            last_name: @donor.last_name,
            email: @donor.email
          )
          @donor.update_attribute(:braintree_customer_id, braintree_user.customer.id)
        end

        it "creates payment" do
          expect(subject.success?).to be true
        end
      end
    end

    context "when subscription_payment" do
      before do
        @donor  = FactoryGirl.create :donor
        @params = {
          payment_method_nonce: 'fake-valid-nonce',
          total: '50.00',
          gift_frequency: 'quarterly'
        } 
      end

      subject { BraintreeService.call('create_subscription', @donor, @params) }

      context "when donor has no braintree_customer_id" do
        it "creates payment" do
          expect(subject.success?).to be true
        end
      end

      context "when donor has braintree_customer_id" do
        before do
          braintree_user = Braintree::Customer.create(
            first_name: @donor.first_name,
            last_name: @donor.last_name,
            email: @donor.email
          )
          @donor.update_attribute(:braintree_customer_id, braintree_user.customer.id)
        end

        it "creates payment" do
          expect(subject.success?).to be true
        end
      end
    end
  end

  describe "::get_payment_method" do
    context "when braintree_customer_id is invalid" do
      it "returns nil" do
        expect(BraintreeService.get_payment_token('invalid')).to be_nil
      end
    end

    context "when braintree_customer_id is valid" do
      before do
        @braintree_customer = Braintree::Customer.create(first_name: 'Darth').customer
        @braintree_payment_method = Braintree::PaymentMethod.create(
          customer_id: @braintree_customer.id,
          payment_method_nonce: 'fake-valid-nonce'
        ).payment_method
      end

      subject { BraintreeService.get_payment_token(@braintree_customer.id) }

      it "returns payment method token" do
        expect(subject).to eq @braintree_payment_method.token
      end
    end
  end
end