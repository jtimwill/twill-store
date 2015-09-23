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
    auth_hash = request.env["omniauth.auth"]
    if User.find_by(uid: auth_hash.uid, provider: auth_hash.provider)
      session[:user_id] = user.id
      flash[:info] = 'You are signed in'
      redirect_to root_path
    else
      begin
        user = User.new(uid: auth_hash.uid, provider: auth_hash.provider, username: auth_hash.info.name, email: auth_hash.info.email)
        user.save!
        session[:user_id] = user.id
        flash[:info] = 'You are signed in'
        redirect_to root_path
      rescue => e
        flash[:danger] = "#{e.message}"
        redirect_to login_path
      end
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = 'You are signed out.'
    redirect_to root_path
  end
end
