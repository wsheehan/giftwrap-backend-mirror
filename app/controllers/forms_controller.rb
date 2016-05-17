class FormsController < ApplicationController
	after_action :allow_iframe, only: :show
	layout false

  def show
    @donor = Donor.find_by(key: params[:key])
    @school = @donor.school unless @donor.nil?
  	@form = Form.find(params[:id])
  end

  private
  
  	def allow_iframe
  		response.headers.except! 'X-Frame-Options'
  	end

end
