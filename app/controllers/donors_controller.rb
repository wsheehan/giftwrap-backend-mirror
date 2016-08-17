class DonorsController < ApplicationController
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
end
