class ApplicationController < ActionController::Base
  # before_action :authenticate_user!

  protected

  def authenticate?
    return if signed_in?

    redirect_to root_path, alert: 'Access denied. You need to authorize'
  end
end
