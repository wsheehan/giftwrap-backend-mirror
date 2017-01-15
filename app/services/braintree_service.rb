module BraintreeService
  
  def self.call(action, *args)
    BraintreeService::Transaction.new(*args).send(action.to_sym)
  end

  def self.get_payment_token(braintree_customer_id)
    begin
      braintree_customer = Braintree::Customer.find(braintree_customer_id)
      braintree_customer.payment_methods[0].token
    rescue Braintree::NotFoundError
      return nil
    end
  end

  class Transaction

    def initialize(donor, opts={})
      @donor = donor
      @opts  = opts
    end

    def create_one_time_payment
      find_braintree_user
      process_payment_method
      process_one_time_payment
    end

    def create_subscription
      find_braintree_user
      result = process_payment_method
      process_subscription(result.payment_method.token)
    end

    private

      def find_braintree_user
        begin
          @braintree_user = Braintree::Customer.find(@donor.braintree_customer_id || 'empty')
        rescue Braintree::NotFoundError
          create_braintree_user
        end
      end

      def create_braintree_user
        @braintree_user = Braintree::Customer.create(
          first_name: @donor.first_name,
          last_name: @donor.last_name,
          email: @donor.email
        ).customer
        @donor.update_attribute(:braintree_customer_id, @braintree_user.id)
      end

      def process_payment_method
        Braintree::PaymentMethod.create(
          customer_id: @donor.braintree_customer_id,
          payment_method_nonce: @opts[:payment_method_nonce]
        )
      end

      def process_one_time_payment
        result = Braintree::Transaction.sale(
          customer_id: @donor.braintree_customer_id,
          amount: @opts[:total],
          options: {
            submit_for_settlement: true
          }
        )
        result
      end

      def process_subscription(token)
        result = Braintree::Subscription.create(
          plan_id: "charge_#{@opts[:gift_frequency]}",
          payment_method_token: token,
          price: BigDecimal.new(@opts[:total])
        )
        result
      end

  end
end