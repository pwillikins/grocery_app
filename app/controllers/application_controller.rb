class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
