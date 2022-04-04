class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @items = Item.where(is_active: 'true')
  end

  def show
  end
end
