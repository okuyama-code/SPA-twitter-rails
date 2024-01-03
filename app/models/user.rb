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

  before_create :attach_default_image

  def attach_default_image
    icon.attach(io: File.open(Rails.root.join('app/assets/images/icon.png')), filename: 'icon.png')
    header.attach(io: File.open(Rails.root.join('app/assets/images/header.png')), filename: 'header.png')
  end


end
