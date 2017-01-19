class Api::V1::ClientsController < ApplicationController
  skip_before_action :authenticate_user

  def show
    @client = Client.find(params[:id])
    if @client
      render json: { "client": @client }
    else
      render json: {}, status: :forbidden
    end
  end
end
