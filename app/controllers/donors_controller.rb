class DonorsController < ApplicationController
  def index
    render json: { "donors": Donor.all }
  end

  def show
    @donor = params[:email].present? ? find_by_email : Donor.find(params[:id])
    render json: @donor
  end

  def update
  end

  def edit
  end

  private

    def find_by_email
      @school = School.find(params[:school_id])
      @school.donors.find_by(email: params[:email])
    end

end
