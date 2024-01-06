# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_one_attached :icon
  has_one_attached :header

  validates :name, presence: true
  validates :email, presence: true

  has_many :posts, dependent: :destroy
  has_many :comments # User.commentsで、ユーザーの所有するコメントを取得できる。
  has_many :reposts, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_many :relationships, foreign_key: :following_id
  has_many :followings, through: :relationships, source: :follower

  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followers, through: :reverse_of_relationships, source: :following




  before_create :attach_default_image

  def attach_default_image
    icon.attach(io: Rails.root.join('app/assets/images/icon.png').open, filename: 'icon.png')
    header.attach(io: Rails.root.join('app/assets/images/header.png').open, filename: 'header.png')
  end
end
