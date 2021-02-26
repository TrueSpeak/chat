# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  extend Enumerize

  ROLES = %i[admin moderator user].freeze
  has_many :messages
  has_many :comments
  has_one :black_list

  validates :role, presence: true
  validates :email, presence: true

  enumerize :role, in: ROLES, predicates: true
end
