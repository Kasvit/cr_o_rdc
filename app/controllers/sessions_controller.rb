class SessionsController < ApplicationController

  def new
      
  end

  def create
    user = User.find_by(email: params.dig(:session, :email).downcase)
    if user && user.authenticate(params.dig(:session, :password))
      session[:user_id] = user.id
      flash[:success] = "You have been logined"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "There was something wrong with your login information"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have log out"
    redirect_to root_path
  end

end