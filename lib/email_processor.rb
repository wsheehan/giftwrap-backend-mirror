class EmailProcessor
  def initialize email
    @email = email
  end

  def process
    @donor = Donor.find_by email: @email.from[:email]
    @gift = @donor.gifts.build(total: @email.body)
    if @gift.save
      # Send Confirmation email
    else
      # Send Retry email
    end
  end
end