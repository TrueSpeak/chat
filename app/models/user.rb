class User < ApplicationRecord
  extend Enumerize

  ROLES = %i[admin moderator user].freeze
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :messages
  has_many :comments
  has_one :black_list

  validates :role, presence: true
  validates :email, presence: true

  enumerize :role, in: ROLES, predicates: true
end
