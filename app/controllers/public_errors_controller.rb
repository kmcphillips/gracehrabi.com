class PublicErrorsController < ApplicationController

  def internal_server_error
    render :template => "shared/errors/500", :status => 500
  end

  def not_found
    render :template => "shared/errors/404", :status => 404
  end

  def unprocessable_entity
    render :template => "shared/errors/500", :status => 500
  end

  def conflict
    render :template => "shared/errors/500", :status => 500
  end

  def method_not_allowed
    render :template => "shared/errors/500", :status => 500
  end

  def not_implemented
    render :template => "shared/errors/500", :status => 500
  end

end
