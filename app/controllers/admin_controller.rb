class AdminController < ActionController::Base
  include Admin::V1::SessionsHelper
  before_action :check_for_admin

  def check_for_admin
    unless logged_in? && admin?
      redirect_to login_path
    end
  end
end