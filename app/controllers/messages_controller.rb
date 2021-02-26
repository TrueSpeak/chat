# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate!, only: %i[destroy create]
  after_action :publish_message, only: %i[create destroy]

  def create
    @message = current_user.messages.create(params_permit)
  end

  def index
    @messages = Message.all.order(id: :desc)
    @message = Message.new
  end

  def destroy
    @message = Message.find(params[:id])
    authorize! @message, to: :destroy?, with: MessagePolicy

    @message.destroy
  end

  private

  def publish_message
    return if @message.errors.any?

    if @message.persisted?
      push_to_stream('created')
    elsif @message.destroyed?
      push_to_stream('destroyed')
    end
  end

  def push_to_stream(action)
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
