class Api::V1::Campaigns::TextsController < ApplicationController

  def create
    unless create_campaign
      render json: { "errors": @campaign.errors.present? ? @campaign.errors : @text.errors }
      return
    end
    send_batch
    render json: [{ "campaign": @campaign },{ "text": @text },{ "errors": @twilio_errors}]
  end

  private

    def send_batch
      @twilio_errors = {}
      @campaign.donor_lists.each do |list|
        list.donors.each do |donor|
          send_text(donor, @campaign.id)
          Metric::CampaignConversion.create(campaign: @campaign, donor: donor)
        end
      end
    end

    def send_text(donor, cid)
      begin
        @client = Twilio::REST::Client.new
        @client.messages.create(
          from: "+#{params[:text][:from]}",
          to: "+#{donor.phone_number}",
          body: params[:text][:body] + " https://localhost:4200/#{donor.client.id}?k=#{donor.key}&c=#{cid}"
        )
      rescue Twilio::REST::RequestError => error
        @twilio_errors["#{number}"] = error.message
      end
    end

    def create_campaign
      @campaign = ::Campaign.new(campaign_params)
      @campaign.save ? save_text : false
    end

    def save_text
      @text = @campaign.build_text(text_params.except(:to))
      @text.save
    end

    def text_params
      params.require(:text).permit(:to, :body, :from)
    end

    def campaign_params
      params.require(:campaign).permit(:user_id, :client_id, donor_list_ids: [])
    end

end
