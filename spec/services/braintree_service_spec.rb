require 'rails_helper'

RSpec.describe BraintreeService do

  describe "::call" do
    pending "this is getting random failures"

    # context "when one_time_payment" do
    #   before do
    #     @donor  = FactoryGirl.create :donor
    #     @params = {
    #       payment_method_nonce: 'fake-valid-nonce',
    #       total: '50.00'
    #     } 
    #   end

    #   subject { BraintreeService.call('create_one_time_payment', @donor, @params) }

    #   context "when donor has no braintree_customer_id" do
    #     it "creates payment" do
    #       expect(subject.success?).to be true
    #     end
    #   end

    #   context "when donor has braintree_customer_id" do
    #     before do
    #       braintree_user = Braintree::Customer.create(
    #         first_name: @donor.first_name,
    #         last_name: @donor.last_name,
    #         email: @donor.email
    #       )
    #       @donor.update_attribute(:braintree_customer_id, braintree_user.customer.id); binding.pry
    #     end

    #     it "creates payment" do
    #       expect(subject.success?).to be true
    #     end
    #   end
    # end
  end
end