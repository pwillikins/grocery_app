class ShoppingListItemsController < ApplicationController
  before_filter :authenticate

  def index
    @shopping_list_items = current_shopping_list.shopping_list_items
  end

  def create
    @shopping_list = current_shopping_list
    @shopping_list_item = @shopping_list.shopping_list_items.new(name: params[:name],
                                                                 product_id: params[:product_id],
                                                                 purchased: false)
    if @shopping_list_item.save
      product = Product.find(params[:product_id])
      session[:shopping_list_id] = @shopping_list.id
      redirect_to products_path(item_id: product.item_id)
    else
      redirect_to products_path(item_id: product.item_id)
    end
  end

  def update
    @shopping_list = current_shopping_list
    @shopping_list_item = @shopping_list.shopping_list_items.find(params[:id])
  end

  def purchased
    shopping_list_item = ShoppingListItem.find(params[:id])
    shopping_list_item.update_attribute(:purchased, true)
    product = Product.find(shopping_list_item.product_id)
    redirect_to cart_path
  end

  def destroy
    @shopping_list = current_shopping_list
    if params[:product_id].present?
      product = Product.find(params[:product_id])
      item_id = product.item_id
      @shopping_list_item = @shopping_list.shopping_list_items.find_by_product_id(params[:product_id])
      @shopping_list_item.destroy
      redirect_to products_path(item_id: item_id)
    else
      @shopping_list_item = @shopping_list.shopping_list_items.find(params[:id])
      @shopping_list_item.destroy
      redirect_to cart_path
    end
  end

  private

  def shopping_list_item_params
    params.require(:shopping_list_item).permit(:name, :product_id, :purchased)
  end
end


# add attribute called purchased and use as boolean
# after the list is created, the list will have a purchase button next to each item,
# when the button is selected we'll set the shopping_list_item attribute 'purchased' to true
