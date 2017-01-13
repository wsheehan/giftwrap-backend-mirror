module BraintreeService
  extend self

  def process_payment(donor, gift_params)
    if donor.has_payment_info? && !gift_params[:new_payment_method]
      payment = Braintree::Transaction.sale(
        customer_id: donor.braintree_customer_id,
        amount: gift_params[:total],
        options: {
          submit_for_settlement: true
        }
      )
    else
      payment = Braintree::Transaction.sale(
        amount: gift_params[:total],
        payment_method_nonce: gift_params[:payment_method_nonce],
        customer: {
          first_name: donor.first_name,
          last_name: donor.last_name,
          email: donor.email
        },
        options: {
          store_in_vault: true,
          submit_for_settlement: true
        }
      )
      if payment.success?
        donor.update_attribute(:braintree_customer_id, payment.transaction.customer_details.id)
      end
    end
    payment
  end

  def process_subscription
    # def process_user
    #   new_user = Braintree::Customer.create(
    #     first_name: @current_user.first_name,
    #     last_name: @current_user.last_name,
    #     email: @current_user.email
    #   )
    #   @current_user.update_attribute(:braintree_customer_id, new_user.customer.id)
    #   new_user
    # end

    # def process_payment_method(user)
    #   Braintree::PaymentMethod.create(
    #     customer_id: @current_user.braintree_customer_id,
    #     payment_method_nonce: @nonce
    #   )
    # end

    # def process_subscription
    #   braintree_customer = Braintree::Customer.find(@current_user.braintree_customer_id )
    #   Braintree::Subscription.create(
    #     plan_id: 'yearly_plan',
    #     payment_method_token: braintree_customer.payment_methods.first.token,
    #     price: @admin_test ? BigDecimal.new("1.00") : BigDecimal.new(@yearly_total)
    #   )
    # end
  end
end