class Api::V1::FormsController < ApplicationController
  skip_before_action :authenticate_user

  def show
    @client = Client.find(params[:id])
    if @client.form.present?
      render json: { "form": @client.form }
    else
      render json: {}, status: :forbidden
    end
  end

end
