class FormsController < ApplicationController
  include Client::Logic

	after_action :allow_iframe, only: :show

  def show
    if client_validated?(params)
      @donor = Donor.find_by(key: params[:key])
      @payment_method = find_payment_method @donor if @donor && @donor.braintree_customer_id
      @form = Form.find(params[:id])
      @school = @form.school
      @client_token = Braintree::ClientToken.generate
      @request_url = params[:request_url]
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
  end

  private

    def find_payment_method donor
      customer = Braintree::Customer.find(donor.braintree_customer_id)
      payment_method = Braintree::PaymentMethod.find(customer.payment_methods[0].token) # Will this always be the default?
      if payment_method.class == Braintree::PayPalAccount
        { method: 'Paypal', email: payment_method.email }
      else
        { method: 'Credit Card', card_holder: payment_method.cardholder_name,
          masked_number: payment_method.masked_number, image_url: payment_method.image_url }
      end
    end

end
