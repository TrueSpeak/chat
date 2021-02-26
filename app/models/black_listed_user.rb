# frozen_string_literal: true

class BlackListedUser < ApplicationRecord
  belongs_to :black_list

  validates :black_list_id, :user_id, presence: true
end
