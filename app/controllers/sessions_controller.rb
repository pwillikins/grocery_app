class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if params[:email].present? && params[:password].present?
      email = params[:email]
      @user = User.find_by_email(email)

      if @user
        log_user_in(@user)
        reset_shopping_list
        flash[:notice] = "You're signed in"
        redirect_to user_items_path(user_id: @user.id)
      else
        flash[:alert] = "Email/password incorrect"
        redirect_to sessions_new_path
      end
    else
      flash[:alert] = "Email/Password cannot be blank"
      redirect_to sessions_new_path
    end
  end

  def destroy
    session[:user_id] = nil
    session[:shopping_list_id] = nil
    flash[:notice] = "You have logged out."
    redirect_to sessions_new_path
  end
end