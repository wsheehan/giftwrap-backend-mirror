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
      begin
        user = (JWT.decode request.headers["Authorization"].sub!("Bearer ", ""), Rails.application.secrets.secret_key_base, true, {:algorithm => 'HS256'})[0]
        user["user_id"].present?
      rescue Exception
        false
      end
    end

    def allow_iframe
      response.headers.except! 'X-Frame-Options'
    end

end
