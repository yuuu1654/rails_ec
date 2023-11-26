# frozen_string_literal: true

class CartItemsController < ApplicationController
  def create
    # この関数はカートに追加する為だけの処理なので、インスタンス変数は使わない(メモリの節約・データのカプセル化)
    product_id = params[:product_id].to_i
    quantity = params[:quantity].present? ? params[:quantity].to_i : 1
    session[:cart] ||= []
    # セッション内のカートから、現在追加しようとしている商品(@product.id)と一致する商品を探す
    item = session[:cart].find { |i| i['product_id'] == product_id }
    if item
      item['quantity'] += quantity
    else
      session[:cart] << { product_id:, quantity: }
    end
    redirect_to products_path
  end

  def show
    @cart_items = session[:cart] || []
    logger.debug "cartt_items: #{@cart_items.inspect}"
    @cart_details = @cart_items.map do |item|
      # 以下の書き方だとデータを取得できなかった。add_to_cartでシンボルをキーにして格納したはずやのに...
      # product = Product.find(item[:product_id])
      # total_price = product.price * item[:quantity]
      product = Product.find(item['product_id'])
      total_price = product.price * item['quantity']
      { product:, quantity: item['quantity'], total_price: }
    end
    logger.debug "cart_details: #{@cart_details.inspect}"
    # 今度は逆に以下の書き方だとデータにアクセスできなかった
    # @billed_amount = @cart_details.sum { |item| item["total_price"] }
    @billed_amount = @cart_details.sum { |item| item[:total_price] }
    logger.debug "billed_amount: #{@billed_amount.inspect}"
  end

  def destroy
    session[:cart].delete_if { |item| item['product_id'].to_i == params[:product_id].to_i }
    redirect_to cart_path
  end
end
