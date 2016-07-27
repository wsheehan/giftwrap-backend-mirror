class Api::V1::DonorsController < ApplicationController
  after_action :allow_iframe, only: [:show, :update]

  def show
    @id = params[:id]
    render "forms/update_donor"
  end

  def update
    @donor = Donor.find(params[:id])
    if @donor.update_attributes(donor_params)
      render json: {"Update":"Succeeded"}
    else
      render json: {"Update":"Failed"}
    end
  end

  private

    def donor_params
      params.require(:donor).permit(:first_name, :last_name, :email, :phone_number, :gift_frequency, :affiliation, :class_year)
    end
end