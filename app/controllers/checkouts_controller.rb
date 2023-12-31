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
    ActiveRecord::Base.transaction do
      # 購入者情報と購入明細処理をDBに保存する処理を一つのトランザクションとして実行
      build_order
      # バリデーションエラーの時にトランザクションをロールバック
      raise ActiveRecord::Rollback unless @order.save

      create_order_details(@order) # 購入明細を保存
    end

    # トランザクション後の処理
    if @order.persisted? # @orderが保存済みかどうかをチェック
      OrderMailer.order_detail(@order, @order_details).deliver_now
      reset_session # カートを破棄
      flash[:notice] = 'ご購入ありがとうございます！'
      redirect_to products_path
    else
      set_cart_details # 再入力時にカートの中身が残っているようにする
      render template: 'cart_products/show'
    end
  end

  private

  def order_params
    params.require(:order).permit(:username, :email, :card_name, :card_number, :card_expires, :card_cvv)
  end

  def build_order
    @order = Order.new(order_params)
    @order.cart_id = @cart.id
    @order.name = "#{params[:order][:name_sei]} #{params[:order][:name_mei]}"
    @order.address = "#{params[:order][:address1]} #{params[:order][:address2]}"
    set_cart_details # 割引を考慮した請求額を算出 (todo: モデルに処理を移行)
    @order.billed_amount = @billed_amount
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
