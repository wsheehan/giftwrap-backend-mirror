class Api::V1::GiftsController < ApplicationController
  def create
    @donor = Donor.find(gift_params[:form_donor_id])
    @gift = @donor.gifts.build(gift_params.except(:payment_method_nonce, :form_donor_id))
    if @gift.save
      if process_payment
        render json: { "gift": @gift }
      else
        render json: { "errors": { "msg": @payment.errors } }
      end
    else
      render json: { "errors": { "msg": @gift.errors } }
    end
  end

  private

    def gift_params
      params.require(:gift).permit(:total, :designation, :gift_type, :donor_id, :payment_method_nonce, :form_donor_id)
    end

    def process_payment
      if @donor.has_payment_info?
        # Already in database
        # @payment = Braintree::Transaction.sale(
        #   customer_id: params[:donor][:braintree_customer_id],
        #   amount: gift_params[:total]
        # )
        # false unless @payment.success
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

end
