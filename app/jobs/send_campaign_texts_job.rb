class SendCampaignTextsJob < ApplicationJob
  queue_as :default
  include TwilioService

  def perform(campaign, donor, body)
    begin
      twilio_client = Twilio::REST::Client.new
      twilio_client.messages.create(
        from: TwilioService.get_available_number,
        to: "+#{donor.phone_number}",
        body: body + " https://localhost:4200/#{donor.client.id}?k=#{donor.key}&c=#{campaign.id}"
      )
      Metric::CampaignConversion.create(campaign: campaign, donor: donor)
    rescue Twilio::REST::RequestError => error
      p error
      # Send errors to slack or something? Not sure how to handle these...
    end
  end
end
