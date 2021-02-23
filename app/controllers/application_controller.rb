class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :gon_user

  protected

  def authenticate?
    return if signed_in?

    redirect_to root_path, alert: 'Access denied. You need to authorize'
  end

  private

  def gon_user
    if signed_in?
      gon.current_user_id = current_user.id
      gon.current_user_role = current_user.role
    end
  end
end
