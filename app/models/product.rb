# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true
  validates :description, presence: true
  validates :image, attached: true, content_type: ['image/jpeg', 'image/gif', 'image/png']
end
