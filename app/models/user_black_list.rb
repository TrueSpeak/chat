class UserBlackList < ApplicationRecord
  belongs_to :user
  belongs_to :black_list

  validates :black_list_id, :user_id, presence: true
end
