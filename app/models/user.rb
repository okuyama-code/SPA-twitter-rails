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
  has_many :comments, dependent: :destroy # User.commentsで、ユーザーの所有するコメントを取得できる。
  has_many :reposts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  has_many :relationships, foreign_key: :following_id, dependent: :destroy
  has_many :followings, through: :relationships, source: :follower, dependent: :destroy


  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followers, through: :reverse_of_relationships, source: :following

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  # TODO: DM機能
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :groups, dependent: :destroy

  def create_notification_follow!(current_user, user_id)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and action = ? ', current_user.id, user_id, 'follow'])
    return if temp.present?

    notification = current_user.active_notifications.new(
      visited_id: user_id,
      action: 'follow'
    )
    notification.save if notification.valid?
  end

  before_create :attach_default_image

  def attach_default_image
    icon.attach(io: Rails.root.join('app/assets/images/icon.png').open, filename: 'icon.png')
    header.attach(io: Rails.root.join('app/assets/images/header.png').open, filename: 'header.png')
  end
end
