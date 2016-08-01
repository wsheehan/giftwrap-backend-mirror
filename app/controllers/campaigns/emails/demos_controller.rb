class Campaigns::Emails::DemosController < ApplicationController
  def create
    @donor = Donor.find_by email: params[:donor][:email]
    @campaign = Campaign.create(campaign_params)
    @email = @campaign.build_email(email_params)
    CampaignMailer.send_email_campaign(@campaign, @email, @donor)
    render json: { "Demo Email": "Sent" }
  end

  private

    def campaign_params
      params.require(:campaign).permit(:school_id, :user_id)
    end

    def email_params
      params.require(:email).permit(:title, :body)
    end
end
