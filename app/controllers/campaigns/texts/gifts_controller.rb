class Campaigns::Texts::GiftsController < ApplicationController
  def create
    @total = params[:Body]
    phone_number = params[:From]
    @donor = Donor.find_by phone_number: phone_number[1..-1]
    @gift = @donor.gifts.build(total: @total)
    response = Twilio::TwiML::Response.new do |r|
      if @gift.save
        process_payment
        r.Message "Thank you for you gift of $#{@total}"
      else
        r.Message "We could not process your gift, Please try again"
      end
    end
    render plain: response.text
  end

  private

    def process_payment
      @payment = Braintree::Transaction.sale(
        customer_id: @donor.braintree_customer_id,
        amount: @total
      )
    end
end
