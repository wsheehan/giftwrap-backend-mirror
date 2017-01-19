class Admin::V1::ClientsController < ApplicationController
  
  def create
    client = Client.new(client_params)
    if client.save
      flash[:notice] = "Client saved"
      redirect_to root
    else
      flash[:warning] = "Client did not save"
      redirect_to root
    end
  end

  private

    def client_params
      params.require(:client).permit(:name)
    end
end
