class Api::V1::Campaigns::TextsController < ApplicationController
  def create
    @client = Client.find(global_params[:client_id])
    unless create_campaign
      render json: { "errors": @campaign.errors.present? ? @campaign.errors : @text.errors }
      return
    end
    send_batch
    render json: { "campaigns/text": @campaign.text }, status: :created
  end

  private

    def send_batch
      @campaign.donor_list_donors.each do |donor|
        SendCampaignTextsJob.perform_later(@campaign, donor, text_params)
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
