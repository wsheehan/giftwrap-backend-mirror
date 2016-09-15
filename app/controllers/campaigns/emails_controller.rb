class Campaigns::EmailsController < ApplicationController
  def create
    unless create_campaign
      render json: { "errors": @campaign.errors }
      return
    end
    @email = @campaign.build_email(email_params)
    if @email.save
      send_email
      render json: { "email": @email }
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
      list = @campaign.donor_lists.each do |list|
        list.donors.each do |donor|
          CampaignMailer.send_email_campaign(@campaign, @email, donor).deliver_now
          Metric::Campaign::Conversion.create(campaign: @campaign, donor: donor)
        end
      end
    end

    def campaign_params
      params.require(:campaign).permit(:school_id, :user_id, donor_list_ids: [])
    end

    def email_params
      params.require(:email).permit(:title, :body)
    end
end
