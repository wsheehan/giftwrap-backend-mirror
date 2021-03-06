class CampaignMailer < ApplicationMailer

  def send_email_campaign(campaign, email, donor)
    @campaign = campaign
    @email = email
    @donor = donor
    @url = 'https://localhost:3000/forms/#{@campaign.school_id}?#{donor.key}'
    mail(to: @donor.email, subject: @email.title)
  end

  def demo_campaign(email, donor, client_name)
    @client_name = client_name
    @email = email
    @donor = donor
    mail(to: @donor.email, subject: @email.title)
  end

  def successful_gift(donor, subject)
    @donor = donor
    @subject = subject
    mail(to: @donor.email, subject: @subject)
  end

  def unsuccessful_gift(donor, subject)
    @donor = donor
    @subject = subject
    mail(to: @donor.email, subject: @subject)
  end

end
