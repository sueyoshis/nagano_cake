class Public::OrdersController < ApplicationController
  def new
    @customer = current_customer
    @order = Order.new
  end

  def confirm
    customer = current_customer
    @cart_items = customer.cart_items
    @sum = 0
    @postage = 800
    @order = Order.new(order_params)
    if params[:order][:address_select] == "0"
      @order.postal_code = customer.postal_code
      @order.address = customer.address
      @order.name = customer.full_name
    elsif  params[:order][:address_select] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
  end

  def thanks
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end

end
