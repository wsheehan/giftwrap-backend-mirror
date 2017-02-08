class Api::V1::UsersController < ApplicationController
  def show
    if correct_user?
      @user = User.find(@user_creds["user_id"])
      render json: { "user": UserSerializer.new(@user) }
    else
      render json: {}, status: :forbidden
    end
  end

  def update
    if correct_user?
      @user = User.find(@user_creds["user_id"])
      @user.update_attributes(user_params)
      render json: {}, status: :ok
    else
      render json: {}, status: :forbidden
    end
  end

  private

    def user_params
      params.require("users").permit(:avatar, :first_name, :last_name, :email)
    end

    def correct_user?
      @user_creds["user_id"] == params["id"].to_i
    end
end
