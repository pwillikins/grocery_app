class CartsController < ApplicationController
  before_filter :authenticate

  def show
    @shopping_list_items = current_shopping_list.shopping_list_items
  end
end