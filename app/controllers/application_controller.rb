class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  helper_method :shopping_list_size

  def shopping_list_size
    current_shopping_list.shopping_list_items.where(purchased: false).count
  end

  helper_method :current_shopping_list

  def current_shopping_list
    if !session[:shopping_list_id].nil?
      ShoppingList.find(session[:shopping_list_id])
    else
      ShoppingList.create(name: "Today's Shopping List: #{Time.now}", user_id: current_user.id)
    end
  end

  helper_method :reset_shopping_list

  def reset_shopping_list
    shopping_list = ShoppingList.create(name: "Today's Shopping List: #{Time.now}", user_id: current_user.id)
    session[:shopping_list_id] = shopping_list.id
  end

  helper_method :log_user_in

  def log_user_in(user)
    session[:user_id] = user.id
  end

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :logged_in?

  def logged_in?
    session[:user_id]
  end

  def log_user_out
    session[:user_id] = nil
  end

  private

  helper_method :authenticate

  def authenticate
    redirect_to new_session_path, :notice => "You must be logged in to access this page." unless current_user
  end
end
