# frozen_string_literal: true

class CartProductsController < ApplicationController
  before_action :set_cart_product, only: %i[create destroy]
  before_action :current_cart, only: %i[create show]
  before_action :set_cart_details, only: [:show]

  def create
    @cart_product = @cart.cart_products.build(product_id: params[:product_id]) if @cart_product.blank?
    @cart_product.quantity ||= 0 # nilだと以下の加算ができないので追記
    @cart_product.quantity += params[:quantity].present? ? params[:quantity].to_i : 1
    @cart_product.save
    redirect_to products_path
  end

  def show
    # @orderの表示エラーが起こらないようにする(→インスタンス変数の初期化)
    @order = Order.new
  end

  def destroy
    @cart_product.destroy
    @product = Product.find(@cart_product.product_id)
    flash[:notice] = "#{@product.name}を削除しました"
    redirect_to cart_path
  end

  private

  def set_cart_product
    @cart_product = current_cart.cart_products.find_by(product_id: params[:product_id])
  end
end
