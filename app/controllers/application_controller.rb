# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # コントローラ内で定義したメソッドをビューのテンプレート内でも使えるようにする
  helper_method :current_cart

  def current_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
    @cart
  end
end
