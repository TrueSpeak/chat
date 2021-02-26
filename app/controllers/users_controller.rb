# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate!, only: %i[destroy upgrade_role downgrade_role]
  before_action :set_user, only: %i[destroy show upgrade_role downgrade_role]
  before_action :redirect_when_admin, only: %i[destroy upgrade_role downgrade_role]

  def show; end

  def destroy
    authorize! @user, to: :destroy?, with: UserPolicy
    @user.destroy

    redirect_to users_path
  end

  def index
    authorize! @user, to: :index?, with: UserPolicy

    @users = User.all.where.not(role: 'admin')
  end

  def upgrade_role
    authorize! @user, to: :update?, with: UserPolicy
    @user.update(role: 'moderator')

    flash[:alert] = "#{@user.name} successfully upgraded to moderator"
    redirect_to user_path(@user)
  end

  def downgrade_role
    authorize! @user, to: :update?, with: UserPolicy
    @user.update(role: 'user')

    flash[:alert] = "#{@user.name} successfully downgraded to default"
    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def redirect_when_admin
    if @user.role.include?('admin')
      flash[:alert] = "You can't update/delete administrator role"
      redirect_to user_path(@user)
    end
  end
end
