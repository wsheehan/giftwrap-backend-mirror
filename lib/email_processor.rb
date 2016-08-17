class EmailProcessor
  include Campaign::Validator

  def initialize email
    @email = email
  end

  def process
    validated = validate_response @email.body
    if validated
      @donor = Donor.find_by email: @email.from[:email]
      @gift = @donor.gifts.build(total: validated[0], gift_frequency: validated[1])
      if @gift.save
        CampaignMailer.successful_gift(@donor, @email.from[:subject]).deliver_now
      end
    else
      CampaignMailer.unsuccessful_gift(@donor, @email.from[:subject]).deliver_now
    end
  end
end