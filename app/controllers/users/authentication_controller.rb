class Users::AuthenticationController < ApplicationController
  skip_before_action :authenticate_user

  def create
    user = User.find_by email: user_params[:email]
    if user && user.authenticate(user_params[:password])
      token = JWT.encode user.attributes, Rails.application.secrets.secret_key_base, 'HS256'
      render json: { "user": user, "token": token }
    else
      render json: { "error": user.errors }
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end

end
