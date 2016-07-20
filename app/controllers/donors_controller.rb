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

  def find_by_email
    @school = School.find(params[:school_id])
    @donor = @school.donors.find_by_email(URI.decode(params[:donor_email]))
    if @donor
      render json: @donor
    else
      render json: {}, status: :no_content
    end
  end
end
