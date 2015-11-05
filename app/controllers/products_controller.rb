class ProductsController < ApplicationController
  before_filter :authenticate

  def index
    @item = Item.find(params[:item_id])
    @product = Product.new
    @products = Product.where(item_id: params[:item_id])
    @shopping_list_item = ShoppingListItem.new
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(item_id: params[:product][:item_id], name: params[:product][:name])
    if @product.save
      redirect_to products_path(item_id: @product.item_id)
    else
      render user_items_path
    end
  end


end