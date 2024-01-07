# frozen_string_literal: true

class Post < ApplicationRecord
  validates :post_content, presence: true, length: { maximum: 140 }
  has_one_attached :image
  belongs_to :user
end
