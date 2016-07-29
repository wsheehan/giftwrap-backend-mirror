class Campaigns::DemosController < ApplicationController
  include ActionView::Layouts
  layout 'application'

  def new
  end

  def create
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: "+18023597135",
      to: "+#{params[:text][:number]}",
      body: params[:text][:body] + "\n\nGive Today: https://give-staging.herokuapp.com/campaigns/demos"
    )
    render json: { "Text": "Sent" }
  end
end
