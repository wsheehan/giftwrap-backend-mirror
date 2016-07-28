class CampaignMailer < ApplicationMailer

  def send_email_campaign(campaign, email, donor)
    @campaign = campaign
    @email = email
    @donor = donor
    @url = 'https://localhost:3000/forms/#{@campaign.school_id}?#{donor.key}'
    mail(to: @donor.email, subject: @email.title)
  end

end
