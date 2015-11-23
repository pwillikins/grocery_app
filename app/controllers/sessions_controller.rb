class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if params[:email].present? && params[:password].present?
      @user = User.where(email: params[:email], password: params[:password]).first

      if @user.present?
        log_user_in(@user)
        reset_shopping_list
        flash[:notice] = "You've successfully signed in"
        redirect_to user_items_path(user_id: @user.id)
      else
        flash[:alert] = "Email/password incorrect"
        render new_session_path
      end
    else
      flash[:alert] = "Email/Password cannot be blank"
      render new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    session[:shopping_list_id] = nil
    flash[:notice] = "You have logged out."
    redirect_to sessions_new_path
  end
end