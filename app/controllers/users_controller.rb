class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_parameters)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_items_path(user_id: @user.id)
    else
      render :new
    end
  end

  def allowed_parameters
    params.require(:user).permit(
      :email,
      :password
    )
  end
end