class EmailProcessor
  include Campaign::Validator

  def initialize email
    @email = email
  end

  def process
    validated = validate_response @email.body
    if validated
      @donor = Donor.find_by email: @email.from[:email]
      @conversion = Metric::Campaign::Conversion.where(donor: @donor, campaign_id: 1)
      @gift = @donor.gifts.build(total: validated[0])
      if @gift.save
        if validated[1]
          handle_subscription validated
          @conversion.update_attributes(gift: @gift, gift_method: "respond", subscription: true)
        else
          @conversion.update_attributes(gift: @gift, gift_method: "respond")
        end
        CampaignMailer.successful_gift(@donor, @email.subject).deliver_now
      end
    else
      CampaignMailer.unsuccessful_gift(@donor, @email.subject).deliver_now
    end
  end

  def handle_subscription validated
    @subscription = Subscription.find_by frequency: validated[1]
    @subscription.donors << @donor
    @donor.update_attributes(subscription_start: Date.today, subscription_total: validated[0])
  end
end