class ChangeCreditCardInfoType < ActiveRecord::Migration[7.0]
  def up
    change_column :orders, :card_number, :string
    change_column :orders, :card_expires, :string
    change_column :orders, :card_cvv, :string
  end

  def down
    change_column :orders, :card_number, :integer
    change_column :orders, :card_expires, :integer
    change_column :orders, :card_cvv, :integer
  end
end
