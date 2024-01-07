# frozen_string_literal: true

class Group < ApplicationRecord
  # roomがgroupに変わっただけ

  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
end
