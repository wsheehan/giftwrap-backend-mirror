class Users::AuthenticationController < ApplicationController
  skip_before_action :authenticate_user

  def create
    user = User.find_by email: auth_params[:username]
    if user && user.authenticate(auth_params[:password])
      expiration = Time.now.to_i + 4 * 3600
      payload = { "user_id" => user.id, "client_id" => user.client.try(:id) }
      token = JWT.encode payload, Rails.application.secrets.secret_key_base, 'HS256'
      render json: { "token": token, "user": formatted_user(user) }
    else
      render json: { "error": "Invalid email/password combination" }
    end
  end

  private

    def auth_params
      params.require(:authentication).permit(:username, :password)
    end

    def formatted_user user
      { "first_name" => user.first_name, "last_name" => user.last_name, "email" => user.email, "client_id" => user.client_id, "user_id" => user.id }
    end

end
