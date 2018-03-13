class OrderMailer < ApplicationMailer
  def payment_success_email(user)
    @user = user
    @uniq_products = @user.orders.last.products.uniq
    @order_details = @user.orders.last
    @products = @user.orders.last.ordersproducts
    mail(to: @user.email, subject: 'Payment Is Successful')
  end

  def delivered_email(user)
    @user = user
    mail(to: @user.email, subject: 'Products Have Been Delivered')
  end

  def rejected_email(user)
    @user = user
    @uniq_products = @user.orders.last.products.uniq
    @order_details = @user.orders.last.products
    mail(to: @user.email, subject: 'Order Is Rejected')
  end
end
