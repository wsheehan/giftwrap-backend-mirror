class Api::V1::Campaigns::Texts::GiftsController < ApplicationController
  skip_before_action :authenticate_user
  include Campaign::Validator
  include Campaign::Parser

  def create
    @validated = validate_response params[:Body]
    @response = Twilio::TwiML::Response.new do |r|
      if @validated
        phone_number = params[:From]
        @donor = Donor.find_by phone_number: phone_number[1..-1]
        @conversion = Metric::CampaignConversion.where(donor: @donor).last
        @gift = @donor.gifts.build(total: @validated[0])
        if @gift.save
          if process_payment.success?
            @conversion.update_attributes(gift: @gift, gift_method: "respond", subscription: @validated[1])
            r.Message "Thank you for you gift of $#{@total}"
          else
            r.Message "There was a problem with your payment method, please go to https://www.giftwrape.io/forms/#{@donor.client.id}?k=#{@donor.key}" # put Campaign ID here too
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
      result = BraintreeService.call("create_#{payment_type}", @donor, {
        total: @validated[0],
        gift_frequency: @validated[1]
      })
      result
    end

    def payment_type
      @validated[1].present? ? 'subscription' : 'one_time_payment'
    end

end
