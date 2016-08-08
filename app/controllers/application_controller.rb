class ApplicationController < ActionController::API
  # protect_from_forgery with: :null_session

  before_action :authenticate_user

  private

    def authenticate_user
      unless authenticated?
        render json: { "errors": { "msg": "User Not Authenticated" } }, status: :unauthorized
      end
    end

    def authenticated?
      user = (JWT.decode request.headers["token"], Rails.application.secrets.secret_key_base, true, {:algorithm => 'HS256'})[0]
      user["email"].present?
    end

    def allow_iframe
      response.headers.except! 'X-Frame-Options'
    end

end
