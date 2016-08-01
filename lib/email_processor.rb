class EmailProcessor
  def initialize email
    @email = email
  end

  def process
    @donor = Donor.find_by email: @email.from[:email]
    puts @donor
  end
end