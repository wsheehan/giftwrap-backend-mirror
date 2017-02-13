class Api::V1::Forms::GiftsController < ApplicationController
  include BraintreeService
  skip_before_action :authenticate_user

  def create
    @client = Client.find(gift_params[:client_id])
    find_or_create_donor
    create_gift

    result = BraintreeService.call("create_#{transaction_type}", @donor, gift_params)
    if result.success?
      update_form_conversion(gift_params[:form_conversion_id])
      render json: { gift: @gift }, status: :created
    else
      render json: { errors: result.errors }, status: :bad_request
    end
  end

  private

    def find_or_create_donor
      @donor = Donor.find_by(id: gift_params[:donor_id])
      return if @client.donors.exists?(@donor.id)
      if @donor.present?
        @donor.clients << @client
      else
        find_donor_by_client_and_email
        create_donor
      end
    end

    def find_donor_by_client_and_email
      @donor = @client.donors.find_by_email gift_params[:email]
    end

    def create_donor
      @donor = @client.donors.create(gift_params.slice(:first_name, :last_name, :email, :phone_number, :gift_frequency, :affiliation, :class_year))
    end

    def create_gift
      @gift = @client.gifts.build(gift_params.slice(:total, :designation, :gift_type, :client_id).merge({donor: @donor}))
      @gift.save!
    end

    def update_form_conversion(id)
      @conversion = ::Metric::FormConversion.find(id)
      if @conversion.donor
        @conversion.update_attributes(gift: @gift, donor: @donor)
      else
        @conversion.update_attributes(gift: @gift)
      end
    end

    def transaction_type
      gift_params[:gift_frequency].present? ? 'one_time_payment' : 'subscription'
    end

    def gift_params
      params.require("forms/gift").permit(
        :total,
        :designation,
        :gift_type,
        :payment_method_nonce,
        :first_name,
        :last_name,
        :email,
        :phone_number,
        :gift_frequency,
        :affiliation,
        :class_year,
        :client_id,
        :payment_method,
        :paypal_email,
        :masked_number,
        :credit_image_url,
        :form_conversion_id,
        :new_payment_method,
        :donor_id
      )
    end

end
