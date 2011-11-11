class SessionsController < ApplicationController
  skip_before_filter :require_login, except: [:destroy]
  
  def new
  end
  
  def create
    @user = User.find(params[:user_name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Signed In!'
    else
      flash.now.alert = 'Invalid user name or password'
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Signed Out!'
  end
end