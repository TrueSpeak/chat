class MessagesController < ApplicationController
  before_action :authenticate?, only: [:new, :create]

  def new
    @message = current_user.messages.new
  end

  def create
    @message = current_user.messages.new(params_permit)
    if @message.save
      redirect_to messages_path
    else
      render :new
    end
  end

  def index
    @messages = Message.all
  end

  def destroy
    if current_user.role != 'user'
      Message.find(params[:id]).destroy

      flash[:alert] = 'Message successfully deleted'
      redirect_to messages_path
    end
  end

  private

  def params_permit
    params.require(:message).permit(:body)
  end
end
