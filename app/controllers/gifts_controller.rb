class GiftsController < ApplicationController
  def create
    @donor = Donor.find(gift_params[:donor_id])
    @gift = @donor.gifts.build(gift_params)
    if @gift.save
      render json: { "gift": @gift }
    else
      render json: { "errors": { "msg": @gift.errors.first } }
    end
  end

  private

    def gift_params
      params.require(:gift).permit(:total, :designation, :gift_type, :donor_id)
    end

end
