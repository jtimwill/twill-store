class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:info] = 'You are signed in'
      redirect_to root_path
    else
      flash[:danger] = 'Invalid email or password'
      redirect_to login_path
    end
  end

  def omniauth
    begin
      user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      flash[:info] = 'You are signed in'
      redirect_to root_path
    rescue
      flash[:danger] = 'Authentication failure.'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = 'You are signed out.'
    redirect_to root_path
  end

  def oauth_failure
    redirect_to login_path
  end
end
