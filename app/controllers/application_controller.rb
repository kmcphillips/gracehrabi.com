class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user(user=nil)
    if user
      raise "#{user.class} is not a User model" unless user.is_a?(User)
      session[:current_user] = user.try(:id)
      @current_user = user
    else
      @current_user || User.find_by_id(session[:current_user])
    end
  end
  
  def clear_current_user
    session[:current_user] = nil
  end
  
end
