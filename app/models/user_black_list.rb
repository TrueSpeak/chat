class UserBlackList < ApplicationRecord
  belongs_to :user
  belongs_to :black_list
end
