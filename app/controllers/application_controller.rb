class ApplicationController < ActionController::Base
  protect_from_forgery

  include Authentication

  include ApplicationHelper

end
