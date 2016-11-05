class Api::V1::DonorListsController < ApplicationController
  def index
    @client = Client.find(@user_creds["client_id"])
    render json: { "donor-lists": @client.donor_lists }
  end

  def create
  end

  def show
  end

  def update
  end
end
