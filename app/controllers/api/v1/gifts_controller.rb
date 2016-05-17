module Api
	module V1
		class GiftsController < ApplicationController

			skip_before_filter :verify_authenticity_token

			def create
				school = School.find_by(school_params)
				donor = school.donors.find_by(donor_params)
				if donor.nil?
					donor = school.donors.build(donor_params)
				end
				if donor.save
					donor.create_key
					gift = donor.gifts.build(gift_params)
					if gift.save
						school.gifts << gift
						render json: gift.to_json
					else
						render json: gift.errors.to_json
					end
				else
					render json: donor.errors.to_json
				end
			end

			private

				def gift_params
					params.require(:gift).permit(:total)
				end

				def donor_params
					params.require(:donor).permit(:first_name, :last_name, :email)
				end

				def school_params
					params.require(:school).permit(:id)
				end

		end
	end
end
