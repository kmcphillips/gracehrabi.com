class Admin::SessionsController < ApplicationController

  def new
    @user = current_user || User.new
  end

  def create
    
  end

  def logout
    flash[:notice] = "You have been logged out" if current_user
    session[:current_user] = nil
    redirect_to "/"
  end
  
end
