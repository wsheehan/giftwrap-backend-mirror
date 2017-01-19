class Api::V1::Campaigns::TextsController < ApplicationController

  def create
    unless create_campaign
      render json: { "errors": @campaign.errors.present? ? @campaign.errors : @text.errors }
      return
    end
    send_batch
    render json: { "campaigns/text": @campaign.text }, status: :created
  end

  private

    def send_batch
      @twilio_errors = {}
      @campaign.donor_list_donors.each do |donor|
        send_text(donor, @campaign.id)
        Metric::CampaignConversion.create(campaign: @campaign, donor: donor)
      end
    end

    def send_text(donor, cid)
      begin
        @client = Twilio::REST::Client.new
        @client.messages.create(
          from: "+18023597135",
          to: "+#{donor.phone_number}",
          body: text_params[:body] + " https://localhost:4200/#{donor.client.id}?k=#{donor.key}&c=#{cid}"
        )
      rescue Twilio::REST::RequestError => error
        @twilio_errors["#{donor.phone_number}"] = error.message
      end
    end

    def create_campaign
      @campaign = ::Campaign.new(campaign_params)
      @campaign.save ? save_text : false
    end

    def save_text
      @text = @campaign.build_text(text_params)
      @text.save
    end

    def global_params
      params.require("campaigns/text").permit(:user_id, :client_id, :body, :donor_list_id, :title, :description)
    end

    def campaign_params
      global_params.except(:body)
    end

    def text_params
      global_params.slice(:body)
    end

end
