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

  def set_cart_details
    @cart_products = @cart.cart_products
    @cart_details = @cart_products.map do |item|
      product = Product.find(item.product_id)
      total_price = product.price * item.quantity
      { product:, quantity: item.quantity, total_price: }
    end
    @billed_amount = @cart_details.sum { |item| item[:total_price] }
  end
end
