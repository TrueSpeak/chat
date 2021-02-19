class BlackList < ApplicationRecord
  has_one :user

  validates :user_id, presence: true
end
