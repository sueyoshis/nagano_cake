class Public::CartItemsController < ApplicationController
  
  before_action :authenticate_customer!
  
  def index
    @cart_items = current_customer.cart_items
    @total_price = 0
  end

  def create
    cart_items = current_customer.cart_items
    if cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item = cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.amount += params[:cart_item][:amount].to_i
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
    end
    if @cart_item.save
      redirect_to cart_items_path
    else
      @genres = Genre.all
      @item = Item.find (params[:cart_item][:item_id])
      render 'public/items/show'
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    cart_item = CartItem.where(customer_id: current_customer.id)
    cart_item.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
