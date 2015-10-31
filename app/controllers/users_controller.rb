class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_parameters)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path(user_id: session[:id])
      flash[:notice] = "Welcome to Rock Your Vote #{current_user.email}"
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