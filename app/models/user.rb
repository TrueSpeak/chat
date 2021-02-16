class User < ApplicationRecord
  extend Enumerize

  ROLES = %i[admin, moderator, default]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments, :messages
  has_one :user_black_list
  belongs_to :black_list

  validates :role, presence: true
  validates :email, presence: true

  enumerize :role, in: ROLES, predicates: true
end
