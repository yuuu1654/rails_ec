# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached :image
  has_many :cart_products, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  # rails db:seed が実行できなかったので、一旦コメントアウト
  # validates :image, attached: true, content_type: ['image/jpeg', 'image/gif', 'image/png']
end
