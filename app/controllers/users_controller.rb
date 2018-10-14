class UsersController < ApplicationController
  before_action :require_user, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You are registered and signed in."
      AppMailer.send_welcome_email(@user).deliver_now
      redirect_to root_path
    else
      flash.now[:danger] = "Invalid user information. Please check the errors below."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
