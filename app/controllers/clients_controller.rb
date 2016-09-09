class ClientsController < ApplicationController

  def show
    @client = Client.find(params[:id])
    if @client
      render json: { "client": @client }
    else
      render json: {}, status: :forbidden
    end
  end
end
