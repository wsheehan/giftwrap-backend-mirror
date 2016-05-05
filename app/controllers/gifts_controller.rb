class GiftsController < ApplicationController

	skip_before_filter :verify_authenticity_token

	def create
		# Find if donor has given before
		donor = Donor.find_by(donor_params)
		if donor.nil?
			# If they haven't, create new Donor
			donor = Donor.new(donor_params)
			if donor.save
				puts "New Donor Created: #{donor.inspect}"
			else
				puts "Donor not saved: #{donor.errors}"
			end
		end
		gift = donor.gifts.build(gift_params)
		# Save Gift
		if gift.save
			puts "New Gift Created: #{gift.inspect}"
			render json: gift.to_json
		else
			puts "Gift not saved: #{gift.errors}"
			render json: gift.errors.to_json
		end
	end

	private

		def gift_params
			params.require(:gift).permit(:total)
		end

		def donor_params
			params.require(:donor).permit(:first_name, :last_name, :email)
		end

end
