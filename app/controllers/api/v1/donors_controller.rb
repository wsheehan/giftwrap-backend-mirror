class Api::V1::DonorsController < ApplicationController
  after_action :allow_iframe, only: [:show, :edit, :update]
  include ActionView::Layouts
  layout 'application'

  def show
    @school = School.find(params[:school_id])
    @donor = @school.donors.find_by email: params[:email]
    render json: @donor
  end

  def edit
    @id = params[:id]
    @school_id = params[:school_id]
    render "forms/update_donor"
  end

  def update
    @school = School.find(params[:school_id])
    @donor = @school.donors.find(params[:donor_id])
    if @donor.update_attributes(donor_params)
      render json: { "Update": "Succeeded" }
    else
      render json: { "Update": "Failed" }
    end
  end

  private

    def donor_params
      params.require(:donor).permit(:first_name, :last_name, :email, :phone_number, :gift_frequency, :affiliation, :class_year)
    end
end