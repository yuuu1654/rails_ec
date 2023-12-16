class CheckoutsController < ApplicationController
  before_action :current_cart, only: [:create]

  def create
    @cart_products = @cart.cart_products #カート内の商品を取得
    @order = Order.new(order_params)
    # buildメソッドが使えなかったので、関連のカートidを直接代入
    @order.cart_id = @cart.id
    # DBに保存する為データを整形
    @order.name = "#{params[:order][:name_sei]} #{params[:order][:name_mei]}"
    @order.address = "#{params[:order][:address1]} #{params[:order][:address2]}"
    # logger.debug "order_st: #{@order.inspect}"
    if @order.save
      # カート内の商品(@cart_products)を購入明細テーブルに保存
      @cart_products.each do |cart_product|
        product = Product.find(cart_product[:product_id])
        @order.order_details.create(
          product_name: product.name,
          price: product.price,
          quantity: cart_product[:quantity],
          total_price: product.price * cart_product[:quantity]
        )
      end
      flash[:notice] = "購入ありがとうございます"
      # 購入明細をメール送信する
      @order_details = @order.order_details
      OrderMailer.order_detail(@order, @order_details).deliver_now
      reset_session # カートを空にする
      redirect_to products_path
    else
      redirect_to cart_path
    end
  end

  private

  def order_params
    params.require(:order).permit(:username, :email, :card_name, :card_number, :card_expires, :card_cvv)
  end
end
