class Admin::OrdersController < ApplicationController
  
  before_action :authenticate_admin!
  
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def update
    order = Order.find(params[:id])
    if  order.update(order_params)
      change_status_payment_confirmation = order.status_before_last_save == 'awaiting_paymant' and order.status == 'payment_confirmation'
      order.order_items.update_all(production_status: 'waiting_for_production') if change_status_payment_confirmation
    end
    redirect_to admin_order_path(order)
  end

  def customer_order
    @orders = Order.where(customer_id: params[:id]).page(params[:page]).order(created_at: "DESC")
    @customer = Customer.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
