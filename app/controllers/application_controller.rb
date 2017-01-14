class ApplicationController < ActionController::API
  # protect_from_forgery with: :null_session

  before_action :authenticate_user

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

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

    def render_unprocessable_entity_response(exception)
      render json: exception.record.errors, status: :unprocessable_entity
    end

    def render_not_found_response(exception)
      render json: { error: exception.message }, status: :not_found
    end

end
