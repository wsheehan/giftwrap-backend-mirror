class FormsController < ApplicationController
	after_action :allow_iframe, only: :show
	layout false

  def show
  	@form = Form.find(params[:id])
  	@params = request.params
  	puts @params
  end

  private
  
  	def allow_iframe
  		response.headers.except! 'X-Frame-Options'
  	end

end
