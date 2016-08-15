class EmailProcessor
  def initialize email
    @email = email
  end

  def process
    @donor = Donor.find_by email: @email.from[:email]
    @gift = @donor.gifts.build(total: @email.body)
    if @gift.save
      CampaignMailer.successful_gift @donor
    else
      CampaignMailer.unsuccessful_gift @donor
    end
  end
end