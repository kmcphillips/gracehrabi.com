class Admin::SessionsController < ApplicationController

  def new
    if current_user
      redirect_to "/admin"
    end
  end

  def create
    if User.authenticate(params)
      redirect_to "/admin"
    else
      flash[:error] = "Incorrect username or password"
      redirect_to "/admin/login"
    end
  end

  def logout
    flash[:notice] = "You have been logged out" if current_user
    clear_current_user
    redirect_to "/"
  end
  
end
