# frozen_string_literal: true

class CartProductsController < ApplicationController
  before_action :set_cart_product, only: %i[create destroy]

  def create
    @cart_product = current_cart.cart_products.build(product_id: params[:product_id]) if @cart_product.blank?
    @cart_product.quantity ||= 0 # nilだと以下の加算ができないので追記
    @cart_product.quantity += params[:quantity].present? ? params[:quantity].to_i : 1
    @cart_product.save
    redirect_to products_path
  end

  def show
    @cart_products = current_cart.cart_products
    @cart_details = @cart_products.map do |item|
      product = Product.find(item.product_id)
      total_price = product.price * item.quantity
      { product:, quantity: item.quantity, total_price: }
    end
    logger.debug "cart_details_st: #{@cart_details.inspect}"
    @billed_amount = @cart_details.sum { |item| item[:total_price] }
  end

  def destroy
    @cart_product.destroy
    redirect_to cart_path
  end

  private

  def set_cart_product
    @cart_product = current_cart.cart_products.find_by(product_id: params[:product_id])
  end
end
