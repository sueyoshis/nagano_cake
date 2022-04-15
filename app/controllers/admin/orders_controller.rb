class Admin::OrdersController < ApplicationController
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

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
