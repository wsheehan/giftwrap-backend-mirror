class Api::V1::UsersController < ApplicationController
  def show
    if @user_creds["user_id"] == params["id"].to_i
      @user = User.find(@user_creds["user_id"])
      render json: { "user": UserSerializer.new(@user) }
    else
      render json: {}, status: :forbidden
    end
  end
end
