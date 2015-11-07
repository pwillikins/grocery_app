class ProductsController < ApplicationController
  before_filter :authenticate

  def index
    @item = Item.find(params[:item_id])
    @product = Product.new
    @products = Product.where(item_id: params[:item_id])
    @shopping_list_item = ShoppingListItem.new
    list_items = current_shopping_list.shopping_list_items
    @added_items = @products.select { |product| list_items.collect(&:product_id).include?(product.id) }
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

  def destroy
    product = Product.find(params[:id])
    item_id = product.item_id
    product.destroy
    redirect_to products_path(item_id: item_id)
  end

end