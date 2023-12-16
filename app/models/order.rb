class Order < ApplicationRecord
  belongs_to :cart, optional: true # orderがなくてもcartは存在する
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
