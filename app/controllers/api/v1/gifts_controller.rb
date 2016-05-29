class Api::V1::GiftsController < ApplicationController
	after_action :allow_iframe, only: :create
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
			payment = process_payment(donor, gift)
			if gift.save && payment.success?
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

		def process_payment(donor, gift)
      if donor.has_payment_info?
        # Already in database
        payment = Braintree::Transaction.sale(
          :amount => params[:gift][:total],
          :payment_method_nonce => params[:payment_method_nonce]
        )
      else
        # Add user into Braintree's database
        payment = Braintree::Transaction.sale(
          amount: params[:gift][:total],
          payment_method_nonce: params[:payment_method_nonce],
          customer: {
            first_name: donor.first_name,
            last_name: donor.last_name,
            email: donor.email
          },
          options: {
            store_in_vault: true
          }
        )
        # Update User's payment credentials in our database
        donor.update_attribute(:braintree_customer_id, payment.transaction.customer_details.id)
      end
      payment
    end

  	def allow_iframe
  		response.headers.except! 'X-Frame-Options'
  	end

end

