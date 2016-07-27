class DonorsController < ApplicationController
  def index
    render json: { "donors": Donor.all }
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
