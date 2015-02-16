class ApplicationController < ActionController::Base
  protect_from_forgery

  include ApplicationHelper

  protected

  def access_denied(error)
    sign_out current_user if current_user
    flash[:error] = "You cannot login or access the admin at this time. Site temporarily in read-only mode."
    redirect_to new_user_session_path
  end

end
