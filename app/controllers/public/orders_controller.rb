class Public::OrdersController < ApplicationController
  def new
    @customer = current_customer
    @order = Order.new
  end

  def confirm
    customer = current_customer
    @cart_items = customer.cart_items
    @total_price = 0
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

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      cart_items = current_customer.cart_items
      cart_items.each do |cart_item|
        order_item = OrderItem.new(order_item_params)
        order_item.order_id = @order.id
        order_item.item_id =  cart_item.item_id
        order_item.price =  cart_item.item.price
        order_item.amount =  cart_item.amount
        order_item.save
      end
      cart_items.destroy_all
      redirect_to orders_thanks_path
    else
      @customer = current_customer
      render :new
    end
  end

  def thanks
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :postage, :billing_amount)
  end

  def order_item_params
    params.permit(:price, :amount)
  end

end
