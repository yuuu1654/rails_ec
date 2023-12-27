class AddDefaultFalseToUsedInPromotionCodes < ActiveRecord::Migration[7.0]
  def change
    # デフォルト値をfalseに設定
    change_column_default :promotion_codes, :used, from: nil, to: false
    # NOT NULL設定
    change_column_null :promotion_codes, :used, false
  end
end
