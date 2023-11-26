# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  before_action :admin?, only: %i[index show]
  def index
    @products = Product.all
  end

  def show
    @related_products = Product.all.order('created_at desc').limit(4)
  end

  def show_cart
    @cart_items = session[:cart] || []
    logger.debug "cart_items: #{@cart_items.inspect}"
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

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def admin?
    @admin = false
  end
end
