class Api::V1::Forms::DonorsController < ApplicationController
  skip_before_action :authenticate_user

  def show
    @donor = Donor.find(params[:id])
    render json: { "donor": @donor }
  end

  def index
    client = Client.find(params[:c])
    @donor = client.donors.find_by_key params[:k]
    @payment_details = @donor.get_payment_info if @donor.has_payment_info?
    puts formatted_donor
    render json: { "forms/donor": formatted_donor }
  end

  private

    def formatted_donor
      d = { "first_name" => @donor.first_name, "last_name" => @donor.last_name, "email" => @donor.email,
      "phone_number" => @donor.phone_number, "gift_frequency" => @donor.gift_frequency, "id" => @donor.id }
      @payment_details ? d.merge!(@payment_details) : d
    end

end
