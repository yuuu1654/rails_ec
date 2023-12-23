# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def order_detail(order, order_details)
    @order = order
    @order_details = order_details
    mail(to: @order.email, subject: 'ご購入ありがとうございます')
  end
end
