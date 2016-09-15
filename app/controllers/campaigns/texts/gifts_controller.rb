class Campaigns::Texts::GiftsController < ApplicationController
  skip_before_action :authenticate_user
  include Campaign::Validator
  include Campaign::Parser

  def create
    @validated = validate_response params[:Body]
    @response = Twilio::TwiML::Response.new do |r|
      if @validated
        phone_number = params[:From]
        @donor = Donor.find_by phone_number: phone_number[1..-1]
        @link = "https://localhost:3000/forms/1?k=kjhtkwrjthkerjg&c=102" # Placeholder
        @conversion = Metric::Campaign::Conversion.where(donor: @donor, campaign_id: retrieve_campaign_id(@link)) # Placeholder Campaign ID
        @gift = @donor.gifts.build(total: @validated[0])
        if @gift.save
          if process_payment
            if validated[1]
              handle_subscription @validated
              @conversion.update_attributes(gift: @gift, gift_method: "respond", subscription: true);
            else
              @conversion.update_attributes(gift: @gift, gift_method: "respond")
            end
            r.Message "Thank you for you gift of $#{@total}"
          else
            r.Message "There was a problem with your payment method, please go to http://localhost:4200/forms/#{@donor.client.id}?k=#{@donor.key}" # put Campaign ID here too
          end
        else
          r.Message "We could not process your gift, Please try again"
        end
      else
        r.Message 'Please Enter Your Gift in the format "[total], [gift frequency]" e.g. "50, monthly", available frequencies: monthly, quarterly, annually'
      end
    end
    render plain: @response.text
  end

  private

    def process_payment
      @payment = Braintree::Transaction.sale(
        customer_id: @donor.braintree_customer_id,
        amount: @total
      )
      @payment.success?
    end

end
