class Admin::OrderItemsController < ApplicationController

  def update
    order_item = OrderItem.find(params[:order_id])
    if  order_item.update(order_item_params)
      change_status_production = (order_item.production_status_before_last_save == 'waiting_for_production' and order_item.production_status == 'production')
      order_item.order.update(status: 'production') if change_status_production
    end
    redirect_to admin_order_path(order_item.order_id)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:production_status)
  end

end
