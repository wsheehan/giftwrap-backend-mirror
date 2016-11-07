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
        @user_creds = (JWT.decode request.headers["Authorization"].sub!("Bearer ", ""), Rails.application.secrets.secret_key_base, true, {:algorithm => 'HS256'})[0]
        request.headers['AUTH_CLIENT_ID'] = @user_creds["client_id"]
        request.headers['AUTH_USER_ID'] = @user_creds["user_id"]
        true
      rescue Exception
        false
      end
    end

    def allow_iframe
      response.headers.except! 'X-Frame-Options'
    end

end
