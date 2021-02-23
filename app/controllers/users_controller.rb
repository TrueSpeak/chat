class UsersController < ApplicationController
  before_action :authenticate?, only: [:destroy, :upgrade_role, :downgrade_role]
  before_action :set_user, only: [:destroy, :show, :upgrade_role, :downgrade_role]
  before_action :redirect_when_admin, only: [:destroy, :upgrade_role, :downgrade_role]

  def show
  end

  def destroy
    if current_user.role.include?('admin')
      @user.destroy

      flash[:alert] = 'User successfully deleted'
      redirect_to users_path
    end
  end

  def index
    if current_user&.role != 'admin'
      flash[:alert] = 'Access denied. You need to authorize like admin'
      redirect_to root_path
    else
      @users = User.all.where.not(role: 'admin')
    end
  end

  def upgrade_role
    if current_user.role.include?('admin')
      @user.update(role: 'moderator')

      flash[:alert] = "#{@user.name} successfully upgraded to moderator"
      redirect_to user_path(@user)
    else
      redirect_to root_path, alert: 'Access denied. You need to authorize'
    end
  end

  def downgrade_role
    if current_user.role.include?('admin')
      @user.update(role: 'user')

      flash[:alert] = "#{@user.name} successfully downgraded to default"
      redirect_to user_path(@user)
    else
      redirect_to root_path, alert: 'Access denied. You need to authorize'
    end
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

