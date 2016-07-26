class Api::V1::GiftsController < ApplicationController
  after_action :allow_iframe, only: :create
  include GiftsHelper

  def create
    @school = School.find_by(school_params)
    find_or_create_donor
    if pledge?
      create_gift
      update_conversion
      render html: gift_response_html(@donor.id).html_safe
      return
    end
    process_payment
    if @payment.success?
      create_gift
      update_conversion
      render html: gift_response_html(@donor.id).html_safe
    else
      render json: {}, status: :bad_request
    end
  end

  private

    def gift_params
      params.require(:gift).permit(:total, :designation, :gift_type)
    end

    def donor_params
      params.require(:donor).permit(:first_name, :last_name, :email, :phone_number, :gift_frequency)
    end

    def school_params
      params.require(:school).permit(:id)
    end

    def process_payment
      if @donor.has_payment_info?
        # Already in database
        @payment = Braintree::Transaction.sale(
          customer_id: params[:donor][:braintree_customer_id],
          amount: params[:gift][:total]
        )
      else
        # Add user into Braintree's database
        @payment = Braintree::Transaction.sale(
          amount: params[:gift][:total],
          payment_method_nonce: params[:payment_method_nonce],
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
        end
      end
    end

    def find_or_create_donor
      @donor = @school.donors.find_by(email: params[:donor][:email])
      if @donor.nil?
        @donor = @school.donors.create(donor_params)
        @donor.create_key
      end
      if params[:donor][:gift_frequency]
        subscription = Subscription.find_by(frequency: params[:donor][:gift_frequency])
        subscription.donors << @donor
        @donor.update_attributes(subscription_start: Date.today, subscription_total: params[:gift][:total])
      end
    end

    def create_gift
      @gift = @donor.gifts.create(gift_params)
      @school.gifts << @gift
    end

    def update_conversion
      conv = @school.conversions.find_by(identifier: params[:conversion][:identifier])
      conv.update_attribute(:converted, true)
    end

    def pledge?
      params[:gift][:gift_type] == "pledge"
    end

end

