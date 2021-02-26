class MessagePolicy < ApplicationPolicy
  def destroy?
    !user.user?
  end
end
