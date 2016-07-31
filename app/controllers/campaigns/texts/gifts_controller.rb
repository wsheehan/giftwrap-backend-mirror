class Campaigns::Texts::GiftsController < ApplicationController
  def create
    total = params[:Body]
    phone_number = params[:From]
    @donor = Donor.find_by phone_number: phone_number[1..-1]
    @gift = @donor.gifts.build(total: total)
    if @gift.save
      render json: @gift
    else
      render json: @gift.errors
    end
  end
end
