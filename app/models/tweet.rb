class Tweet < ApplicationRecord
  # validates :tweet_content, presence: true, length: { maximum: 140 }
  has_one_attached :image
  belongs_to :user
end
