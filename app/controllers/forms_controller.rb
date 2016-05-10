class FormsController < ApplicationController
	after_action :allow_iframe, only: :show

  def show
  	render partial: 'forms/show'
  end

  private
  
  	def allow_iframe
  		response.headers.except! 'X-Frame-Options'
  	end

end
