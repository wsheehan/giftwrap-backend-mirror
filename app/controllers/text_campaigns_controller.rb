class TextCampaignsController < ApplicationController
  def index
  end

  def create
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: '+15005550006', # This is a test number that will not actually send a text
      to: params[:donor],
      body: params[:body]
    )
    # Also Save into database
  end

  def show
  end

  def edit
  end

  def update
  end
end
