class MessagesController < ApplicationController
  before_action :authenticate?, only: [:destroy, :create]
  after_action :publish_message, only: [:create, :destroy]

  def create
    @message = current_user.messages.create(params_permit)
  end

  def index
    @messages = Message.all
    @message = Message.new
  end

  def destroy
    unless current_user.user?
      @message = Message.find(params[:id])
      @message.destroy
    end
  end

  private

  def publish_message
    return if @message.errors.any?

    if @message.persisted?
      action = 'created'
    elsif @message.destroyed?
      action = 'destroyed'
    end
    ActionCable.server.broadcast(
      'chat_channel',
      action: action,
      message: @message,
      user_email: @message.user.email
    )
  end

  def params_permit
    params.require(:message).permit(:body)
  end
end
