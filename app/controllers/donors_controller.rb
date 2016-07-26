class DonorsController < ApplicationController
  after_action :allow_iframe, only: :update

  def index
    render json: { "donors": Donor.all }
  end

  def show
    @donor = Donor.find(params[:id])
    render json: { "donor": @donor }
  end

  def update
    @donor = Donor.find(params[:id])
    if @donor.update_attributes(donor_params)
      render json: @donor
    else
      render html: '<p>Could Not Save Donor Info</p>'
    end
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

  private

    def donor_params
      params.require(:donor).permit(:first_name, :last_name, :email, :phone_number, :gift_frequency, :affiliation, :class_year)
    end
end
