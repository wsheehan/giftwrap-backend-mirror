class EmailProcessor
  include Campaign::Validator

  def initialize email
    @email = email
  end

  def process
    puts @email.
    validated = validate_response @email.body
    if validated
      @donor = Donor.find_by email: @email.from[:email]
      @gift = @donor.gifts.build(total: validated[0])
      if @gift.save
        handle_subscription if validated[1]
        CampaignMailer.successful_gift(@donor, @email.subject).deliver_now
      end
    else
      CampaignMailer.unsuccessful_gift(@donor, @email.subject).deliver_now
    end
  end

  def handle_subscription
    @subscription = Subscription.find_by frequency: validated[1]
    @subscription.donors << @donor
    @donor.update_attributes(subscription_start: Date.today, subscription_total: validated[0])
  end
end