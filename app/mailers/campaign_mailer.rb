class CampaignMailer < ApplicationMailer

  def campaign_email(campaign, donor)
    @campaign = campaign
    @donor = donor
    @url = 'https://localhost:3000/forms/#{@campaign.school_id}?#{donor.key}'
    mail(to: @donor.email, subject: @campaign.title)
  end

end
