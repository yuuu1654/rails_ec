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
    set_cart_details
    logger.debug "session_promo_code: #{session['promotion_code'].inspect}"
  end

  def update
    promotion_code = PromotionCode.find_by(code: params[:code])
    if promotion_code && !promotion_code.used
      promotion_code.update(used: true) # ←promotion_codeモデルに移植
      session[:promotion_code] = promotion_code.code
      session[:discount_amount] = promotion_code.discount_amount
    else
      # 誤ったプロモコードを入力した時もプロモコードの要素が表示されるようにする
      session[:promotion_code] = ''
      session[:discount_amount] = 0
    end
    # 請求額を更新
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
