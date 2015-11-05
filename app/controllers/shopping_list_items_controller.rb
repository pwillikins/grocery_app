class ShoppingListItemsController < ApplicationController
  before_filter :authenticate

  def index
    @shopping_list_items = current_shopping_list.shopping_list_items
  end

  def new

  end

  def create
    @shopping_list = current_shopping_list
    @shopping_list_item = @shopping_list.shopping_list_items.new(name: params[:shopping_list_item][:name],
                                                                 product_id: params[:shopping_list_item][:product_id],
                                                                 purchased: false)
    if @shopping_list.save
      @shopping_list_item.save
      product = Product.find(params[:shopping_list_item][:product_id])
      session[:shopping_list_id] = @shopping_list.id
      redirect_to products_path(item_id: product.item_id)
    else
      render root_path
    end
  end

  def update
    @shopping_list = current_shopping_list
    @shopping_list_item = @shopping_list.shopping_list_items.find(params[:id])
    if @shopping_list_item.update_attribute(:purchased, true)
      redirect_to cart_path
      @shopping_list_item = @shopping_list.shopping_list_items
    end
  end

  def destroy
    @shopping_list = current_shopping_list
    @shopping_list_item = @shopping_list.shopping_list_items.find(params[:id])
    @shopping_list_item.destroy
    @shopping_list_items = @shopping_list.shopping_list_items
  end

  private

  def shopping_list_item_params
    params.require(:shopping_list_item).permit(:name, :product_id, :purchased)
  end
end


# add attribute called purchased and use as boolean
# after the list is created, the list will have a purchase button next to each item,
# when the button is selected we'll set the shopping_list_item attribute 'purchased' to true
