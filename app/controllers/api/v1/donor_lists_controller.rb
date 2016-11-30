class Api::V1::DonorListsController < ApplicationController
  def index
    render json: { "donor-lists": DonorList.where(client_id: @user_creds["client_id"]) }
  end

  def create
    @donor_list = DonorList.create(donor_list_params.merge({ client_id: @user_creds["client_id"] }))
    if @donor_list.save
      render json: { "donor-list": @donor_list }
    else
      render json: { "error": {"msg": @donor_list.errors.first } }
    end
  end

  def show
  end

  def update
  end

  private

    def donor_list_params
      params.require("donor_list").permit("title", "description", "donors")
    end
end
