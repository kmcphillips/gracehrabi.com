class ApplicationController < ActionController::Base
  protect_from_forgery

  include StagingAuthentication
  include ApplicationHelper

end
