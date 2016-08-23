class FormsController < ApplicationController
  def show
    #braintree_token = Braintree::ClientToken.generate
    client = Client.find(params[:id])
    render json: { "form": client.form }
  end
end
