# frozen_string_literal: true

class AddBilledAmountToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :billed_amount, :integer
  end
end
