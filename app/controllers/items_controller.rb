class ItemsController < ApplicationController
  before_filter :authenticate

	def index
    @list_of_items = Item.where(user_id: current_user.id)
    @item = Item.new
    @user = current_user
  end

  def new
    @item = Item.new
    @user = current_user
  end

	def create
	  @item = Item.new(user_id: params[:user_id], name: params[:item][:name])
	  if @item.save
	  	redirect_to user_items_path
	  else
	  	render :new
	  end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to user_items_path(user_id: current_user.id)
  end
end
