class Api::V1::DonorListsController < ApplicationController
  def index
    render json: { "donor-lists": DonorList.all }
  end

  def create
  end

  def show
  end

  def update
  end
end
