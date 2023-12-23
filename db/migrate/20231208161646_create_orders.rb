# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :cart, null: false, foreign_key: true, optional: true
      t.string :name
      t.string :username
      t.string :email
      t.string :address
      t.string :card_name
      t.integer :card_number
      t.integer :card_expires
      t.integer :card_cvv

      t.timestamps
    end
  end
end
