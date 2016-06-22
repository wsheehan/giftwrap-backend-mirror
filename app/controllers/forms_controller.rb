class FormsController < ApplicationController
	after_action :allow_iframe, only: :show
	layout false

  def show
    @donor = Donor.find_by(key: params[:key])
    @payment_method = find_payment_method @donor if @donor && @donor.braintree_customer_id
    @form = Form.find(params[:id])
    @school = @form.school
    @client_token = Braintree::ClientToken.generate
  end

  private

    def find_payment_method donor
      customer = Braintree::Customer.find(donor.braintree_customer_id)
      payment_method = Braintree::PaymentMethod.find(customer.payment_methods[0].token)
      if payment_method.class == Braintree::PayPalAccount
        { method: 'Paypal', email: payment_method.email }
      else
        { method: 'Credit Card', card_holder: payment_method.cardholder_name,
          masked_number: payment_method.masked_number, image_url: payment_method.image_url }
      end
    end

end
