class TextCampaignsController < ApplicationController
  def index
  end

  def create
    @client = Twilio::REST::Client.new
    @client.messages.create(
      #from: '+15005550006', # This is a test number that will not actually send a text
      from: '+18023597135',
      to: params[:text_campaign][:donor_number], # For now this only works with my number 16034430335
      body: params[:text_campaign][:body]
    )
    # Also Save into database
    render json: {"Text Status": "Sent"}
  end

  def show
  end

  def edit
  end

  def update
  end
end
