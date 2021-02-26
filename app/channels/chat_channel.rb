# frozen_string_literal: true

class ChatChannel < ApplicationCable::Channel
  def follow
    stream_from 'chat_channel'
  end
end
