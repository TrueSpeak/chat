# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user

  validates :body, :user_id, presence: true
end
