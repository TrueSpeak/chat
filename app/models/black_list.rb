class BlackList < ApplicationRecord
  has_many :user, polymorphic: true
end
