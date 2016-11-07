class Api::V1::DonorLists::SearchController < ApplicationController
  def create
    @search_results = DonorList.search_records(search_params[:q])
    render json: { "search": @search_results[0] }
  end

  private

    def search_params
      params.require("search").permit(:q)
    end
end
