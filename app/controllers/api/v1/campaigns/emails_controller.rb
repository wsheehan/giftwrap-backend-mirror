class Api::V1::Campaigns::EmailsController < ApplicationController
  def create
    unless create_campaign
      render json: { "errors": @campaign.errors }
      return
    end
    @email = @campaign.build_email(email_params)
    if @email.save
      send_email
      render json: { "campaigns/email": @email }
    else
      render json: { "errors": @email.errors }
    end
  end

  private

    def create_campaign
      @campaign = Campaign.new(campaign_params)
      @campaign.save ? true : false
    end

    def send_email
      @campaign.donor_list_donors.each do |donor|
        CampaignMailer.send_email_campaign(@campaign, @email, donor).deliver_later
        Metric::CampaignConversion.create(campaign: @campaign, donor: donor)
      end
    end

    def global_params
      params.require("campaigns/email").permit(:user_id, :donor_list_id, :body, :subject, :header_image, :campaign_id)
    end

    def campaign_params
      global_params.slice(:user_id, :donor_list_id)
    end

    def email_params
      global_params.slice(:body, :subject, :header_image)
    end
end
