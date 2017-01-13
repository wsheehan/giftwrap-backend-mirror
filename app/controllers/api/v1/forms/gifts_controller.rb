class Api::V1::Forms::GiftsController < ApplicationController
  include BraintreeService
  skip_before_action :authenticate_user

  # meant to be moved into ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def create
    @client = Client.find(gift_params[:client_id])
    find_or_create_donor
    
    @gift = @donor.gifts.build(gift_params.slice(:total, :designation, :gift_type))
    @gift.save

    result = BraintreeService.process_payment(@donor, gift_params)
    if result.success?
      update_form_conversion(gift_params[:form_conversion_id])
      render json: { gift: @gift }, status: :created
    else
      render json: { errors: result.errors }, status: :bad_request
    end
  end

  private

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

    def find_or_create_donor
      @donor = Donor.find_by(id: gift_params[:donor_id])

      unless @donor.present?
        @donor = Donor.where(client_id: gift_params[:client_id], email: gift_params[:email]).take
      end

      unless @donor.present?
        @donor = Donor.create(gift_params.slice(:first_name, :last_name, :email, :phone_number, :gift_frequency, :affiliation, :class_year, :client_id))
      end
    end

    def update_form_conversion(id)
      @conversion = ::Metric::FormConversion.find(id)
      if @conversion.donor
        @conversion.update_attributes(gift: @gift, donor: @donor)
      else
        @conversion.update_attributes(gift: @gift)
      end
    end

    # meant to be moved into ApplicationController
    def render_unprocessable_entity_response(exception)
      render json: exception.record.errors, status: :unprocessable_entity
    end

    def render_not_found_response(exception)
      render json: { error: exception.message }, status: :not_found
    end

end
