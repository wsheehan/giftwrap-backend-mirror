class FormsController < ApplicationController

  def show
    @client = Client.find(params[:id])
    if @client.form.present?
      render json: { "form": @client.form }
    else
      render json: {}, status: :forbidden
    end
  end

end
