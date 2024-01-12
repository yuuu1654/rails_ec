# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private

  def current_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'admin' && password == 'ps'
    end
  end

  # カート詳細ページで、カートに入っている商品毎の個数、値段、などの「表示に必要な項目」を算出する (Helperに切り出す？(要検討))
  def set_cart_details
    @cart_products = @cart.cart_products
    @cart_details = @cart_products.map do |item|
      product = Product.find(item.product_id)
      total_price = product.price * item.quantity
      { product:, quantity: item.quantity, total_price: }
    end
    total_amount = @cart_details.sum { |item| item[:total_price] }
    discount_amount = session[:discount_amount] ? session[:discount_amount].to_i : 0
    @billed_amount = total_amount - discount_amount
    @billed_amount = @billed_amount.negative? ? 0 : @billed_amount
    session[:billed_amount] = @billed_amount
  end
end
