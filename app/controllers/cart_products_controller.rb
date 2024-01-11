# frozen_string_literal: true

class CartProductsController < ApplicationController
  before_action :set_cart_product, only: %i[create destroy]
  before_action :current_cart, only: %i[create show update]
  # before_action :set_cart_details, only: [:show]

  def create
    @cart_product = @cart.cart_products.build(product_id: params[:product_id]) if @cart_product.blank?
    @cart_product.quantity ||= 0 # nilだと以下の加算ができないので追記
    @cart_product.quantity += params[:quantity].present? ? params[:quantity].to_i : 1
    @cart_product.save
    redirect_to products_path
  end

  def show
    @order = Order.new # errorメソッドを呼べるようにする
    # todo: カートから商品を削除する処理を非同期で行うように修正 (そうするとカート詳細ページを再読み込みした時にプロモコードが残らないので不自然じゃなくなる)
    # カートから商品を削除したら割引額が消えるのでコメントアウト▼
    # session[:promotion_code] = ""
    # session[:discount_amount] = 0
    set_cart_details
    logger.debug "session_promo_code: #{session['promotion_code'].inspect}"
  end

  def update
    promotion_code = PromotionCode.find_by(code: params[:code])
    if promotion_code && !promotion_code.used
      promotion_code.update(used: true)
      session[:promotion_code] = promotion_code.code
      session[:discount_amount] = promotion_code.discount_amount
      # 請求額を更新
    else
      # 誤ったプロモコードを入力した時もプロモコードの要素が表示されるようにする
      session[:promotion_code] = ''
      session[:discount_amount] = 0
      # 請求額を更新
    end
    set_cart_details

    respond_to do |format|
      format.turbo_stream # update.turbo_stream.erb というファイルを探してくれる
      # format.html { redirect_to cart_path }
    end
  end

  def destroy
    @cart_product.destroy
    @product = Product.find(@cart_product.product_id)
    redirect_to cart_path, notice: "#{@product.name}を削除しました"
    # respond_to do |format|
    #   format.turbo_stream
    #   format.html { redirect_to cart_path, notice: '商品を削除しました' }
    # end
  end

  private

  def set_cart_product
    @cart_product = current_cart.cart_products.find_by(product_id: params[:product_id])
  end
end
