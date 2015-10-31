class ItemsController < ApplicationController
  before_filter :authenticate

	def index
    @list_of_items = Item.where(user_id: current_user.id)
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
end
