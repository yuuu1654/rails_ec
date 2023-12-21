# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :cart
  has_many :order_details, dependent: :destroy
  validates :name, presence: true
  validates :username, presence: true
  validates :email, presence: true
  validates :address, presence: true
  validates :card_name, presence: true
  validates :card_number, presence: true
  validates :card_expires, presence: true
  validates :card_cvv, presence: true
end
