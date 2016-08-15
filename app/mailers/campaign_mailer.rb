class CampaignMailer < ApplicationMailer

  def send_email_campaign(campaign, email, donor)
    @campaign = campaign
    @email = email
    @donor = donor
    @url = 'https://localhost:3000/forms/#{@campaign.school_id}?#{donor.key}'
    mail(to: @donor.email, subject: @email.title)
  end

  def successful_gift donor
    @donor = donor
    mail(to: @donor.email, subject: "#{@donor.first_name}, Thank You for Your Gift")
  end

  def unsuccessful_gift donor
    @donor = donor
    mail(to: @donor.email, subject: "We could not process your response, please try again")
  end

end
