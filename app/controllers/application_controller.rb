class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  include Authentication

  include ApplicationHelper

end
