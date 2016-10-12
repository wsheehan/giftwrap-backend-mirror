class Api::V1::DonorsController < ApplicationController
  def create
    @client = Client.find(donor_params[:client_id])
    @donor = @client.donors.find_by_email donor_params[:email]
    if @donor
      render json: { "donor": @donor }
    else
      @donor = @client.donors.build(donor_params)
      if @donor.save
        render json: { "donor": @donor }
      else
        render json: { "errors": { "msg": @donor.errors.first } }
      end
    end
  end

  def index
    client = Client.find(request.headers["AUTH_CLIENT_ID"])
    render json: { "donors": client.donors.all }
  end

  def show
    @donor = Donor.find(params[:id])
    render json: { "donor": @donor }
  end

  def update
  end

  def edit
  end

  def find_by_email
    @donor = Donor.find_by_email params[:email]
    render json: { "donor": @donor }
  end

  private

    def donor_params
      params.require(:donor).permit(:first_name, :last_name, :email, :phone_number, :gift_frequency, :affiliation, :class_year, :client_id)
    end

end
