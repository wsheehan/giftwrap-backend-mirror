class FormsController < ApplicationController
	after_action :allow_iframe, only: :show
	layout false

  def show
    @donor = Donor.find_by(key: params[:key])
  	@form = Form.find(params[:id])
    @school = @form.school
    @client_token = Braintree::ClientToken.generate
  end

end
