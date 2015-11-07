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
      redirect_to root_path
      flash[:notice] = "Welcome back #{current_user.email}"
    else
      flash[:notice] = "Email/password incorrect"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:shopping_list_id] = nil
    flash[:notice] = "You have logged out."
    redirect_to root_path
  end
end