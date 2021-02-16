class BlackListedUser < ApplicationRecord
  has_one :user
  belongs_to :black_list

  validates :black_list_id, :user_id, presence: true
end
