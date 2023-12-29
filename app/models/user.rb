# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_one_attached :icon
  has_one_attached :header

  validates :name, presence: true
  validates :email, presence: true

  has_many :tweets, dependent: :destroy
  has_many :posts, dependent: :destroy

end
