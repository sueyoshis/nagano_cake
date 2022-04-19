class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @items = Item.where(is_active: 'true').page(params[:page]).per(8)
    @active_items = Item.where(is_active: 'true')
  end

  def show
    @genres = Genre.all
    @item = Item.find (params[:id])
    @cart_item = CartItem.new
  end
  
  def search
    @items = Item.search(params[:word]).page(params[:page]).per(8)
    @genres = Genre.all
    @active_items = @items
    render :index    
  end
  
end
