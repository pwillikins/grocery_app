class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    email = params[:email]
    @user = User.find_by_email(email)

    if @user
      log_user_in(@user)
      reset_shopping_list
      redirect_to user_items_path(user_id: @user.id)
    else
      render :new, alert: "Email/password incorrect"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:shopping_list_id] = nil
    flash[:notice] = "You have logged out."
    redirect_to root_path
  end
end