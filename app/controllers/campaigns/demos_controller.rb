class Campaigns::DemosController < ApplicationController
  def create
    @donor = Donor.find(params[:text][:donor_id])
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: "+18023597135",
      to: "+#{params[:text][:number]}",
      body: params[:text][:body] + "\n\nGive Today: https://give-staging.herokuapp.com/forms/1?key=#{@donor.key}"
    )
    render json: { "Text": "Sent" }
  end
end
