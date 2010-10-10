class Admin::SessionsController < ApplicationController

  def new
    @user = current_user || User.new
  end

  def create

  end

  def logout

  end
  
end
