class Campaigns::Emails::DemosController < ApplicationController

  def create
    @donor = Donor.find_by email: email_params[:donor_email]
    @campaign = Campaign.create(email_params[:user_id])
    @email = @campaign.build_email(title: email_params[:title], body: email_params[:body])
    if Rails.env.production?
      CampaignMailer.demo_campaign(@email, @donor, email_params[:client_name]).deliver_now
      render json: { "Demo Email": "Sent" }
    else
      render json: { "Demo Email": "Demo Email successful, but not sent" }
    end
  end

  private

    def email_params
      params.require("campaigns/emails/demo").permit(:title, :body, :donor_email, :user_id, :client_name)
    end

end
