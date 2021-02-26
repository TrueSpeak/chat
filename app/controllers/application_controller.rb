# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActionPolicy::Unauthorized, with: :unauthorized_redirect
  before_action :gon_user

  protected

  def authenticate!
    return if signed_in?

    unauthorized_redirect
  end

  private

  def unauthorized_redirect
    redirect_to root_path, alert: 'Access denied. You need to authorize'
  end

  def gon_user
    if signed_in?
      gon.current_user_id = current_user.id
      gon.current_user_role = current_user.role
    end
  end
end
