# frozen_string_literal: true

class CheckoutsController < ApplicationController
  before_action :current_cart, only: %i[index show create]
  before_action :basic_auth, only: %i[index show]

  def index
    # @order_details = OrderDetail.all.group_by(&:order_id)
    @order_details = OrderDetail.select(:order_id).distinct.order(:order_id)
  end

  def show
    @order = Order.find(params[:order_id])
    @order_details = @order.order_details
  end

  def create
    @order = Order.new(order_params)
    @order.cart_id = @cart.id # buildメソッドが使えなかったので、関連のカートidを直接代入
    @order.name = "#{params[:order][:name_sei]} #{params[:order][:name_mei]}"
    @order.address = "#{params[:order][:address1]} #{params[:order][:address2]}"
    if @order.save
      create_order_details(@order) # 購入明細情報を保存
      OrderMailer.order_detail(@order, @order_details).deliver_now # 購入明細をメール送信
      reset_session # カートを空にする
      flash[:notice] = '購入ありがとうございます'
      redirect_to products_path
    else
      set_cart_details # 再入力時にカートの中身が残るようにする
      render template: 'cart_products/show'
    end
  end

  private

  def order_params
    params.require(:order).permit(:username, :email, :card_name, :card_number, :card_expires, :card_cvv)
  end

  def create_order_details(order)
    @cart_products = @cart.cart_products # カート内の商品を取得
    @cart_products.each do |cart_product|
      product = Product.find(cart_product[:product_id])
      order.order_details.create(
        product_name: product.name,
        price: product.price,
        quantity: cart_product[:quantity],
        total_price: product.price * cart_product[:quantity]
      )
    end
    @order_details = @order.order_details
  end
end
