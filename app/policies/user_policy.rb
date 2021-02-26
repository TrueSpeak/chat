# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def destroy?
    admin?
  end

  def update?
    admin?
  end

  def index?
    admin? || user.moderator?
  end

  private

  def admin?
    user.admin?
  end
end
