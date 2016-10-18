class Api::V1::Forms::GiftsController < ApplicationController
  def create
    @client = Client.find(gift_params[:client_id])
    unless find_or_create_donor
      render json: { "errors": { "msg": "Donor Information Could Not Be Saved"} }, status: :bad_request
      return
    end
    @gift = @donor.gifts.build(gift_params.slice(:total, :designation, :gift_type))
    if @gift.save
      if process_payment
        render json: { "gift": @gift }, status: :created
        update_form_conversion gift_params[:form_conversion_id]
      else
        render json: { "errors": { "msg": "Payment Information Did not Process" } }, status: :bad_request
      end
    else
      render json: { "errors": { "msg": "Gift Could not Save" } }, status: :bad_request
    end
  end

  private

    def gift_params
      params.require("forms/gift").permit(:total, :designation, :gift_type, :payment_method_nonce, :first_name,
        :last_name, :email, :phone_number, :gift_frequency, :affiliation, :class_year, :client_id, :payment_method,
        :paypal_email, :masked_number, :credit_image_url, :form_conversion_id)
    end

    def find_or_create_donor
      @donor = @client.donors.find_by_email gift_params[:email]
      # if @donor && gift_params[:gift_frequency]
      #   # handle new subscription
      # end
      if @donor
        true
      else
        @donor = @client.donors.build(gift_params.slice(:first_name, :last_name, :email, :phone_number, :gift_frequency, :affiliation, :class_year, :client_id))
        @donor.save
      end
    end

    def process_payment
      if @donor.has_payment_info?
        # Already in database
        @payment = Braintree::Transaction.sale(
          customer_id: @donor.braintree_customer_id,
          amount: gift_params[:total]
        )
        @payment.success? ? true : false
      else
        # Add user into Braintree's database
        @payment = Braintree::Transaction.sale(
          amount: gift_params[:total],
          payment_method_nonce: gift_params[:payment_method_nonce],
          customer: {
            first_name: @donor.first_name,
            last_name: @donor.last_name,
            email: @donor.email
          },
          options: {
            store_in_vault: true
          }
        )
        if @payment.success?
          @donor.update_attribute(:braintree_customer_id, @payment.transaction.customer_details.id)
          true
        else
          false
        end
      end
    end

    def update_form_conversion id
      @conversion = ::Metric::FormConversion.find(id)
      if @conversion.donor
        @conversion.update_attributes(gift: @gift)
      else
        @conversion.update_attributes(gift: @gift, donor: @donor)
      end
    end

end
