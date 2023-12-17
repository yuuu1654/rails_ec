# frozen_string_literal: true

class ChangeCreditCardInfoType < ActiveRecord::Migration[7.0]
  def up
    change_table :orders, bulk: true do |t|
      t.change :card_number, :string
      t.change :card_expires, :string
      t.change :card_cvv, :string
    end
  end

  def down
    change_table :orders, bulk: true do |t|
      t.change :card_number, :integer
      t.change :card_expires, :integer
      t.change :card_cvv, :integer
    end
  end
end
