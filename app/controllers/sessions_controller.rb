class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    email = params[:email]
    password = params[:password]
    @user = User.find_by_email(email)

    if @user && @user.authenticate(password)
      log_user_in(@user)
      redirect_to user_items_path(user_id: current_user.id)
      flash[:notice] = "Welcome back #{current_user.email}"
    else
      flash[:notice] = "Email/password incorrect"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have logged out."
    redirect_to root_path
  end

end