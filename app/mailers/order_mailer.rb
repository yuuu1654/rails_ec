class OrderMailer < ApplicationMailer

  def order_detail(order, order_details)
    @order = order
    @order_details = order_details
    mail(to: @order.email, subject: "購入明細")
  end
end
