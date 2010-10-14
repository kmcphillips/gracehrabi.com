class ApplicationController < ActionController::Base
  protect_from_forgery

  include Authentication

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

  def require_login
    except = require_login_except rescue []

    unless current_user || except.include?(params[:action])
      flash[:error] = "You must login to view that page."
      redirect_to "/admin/login"
    end
  end

  ## Handle custom dynamic errors
  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => :render_500
    rescue_from ActionController::RoutingError, :with => :render_404
    rescue_from ActionController::UnknownAction, :with => :render_404
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  end

  def render_500
    logger.error "#{$!.class.to_s}: #{$!}"
    logger.error $!.backtrace.join("\n")
    render_error(500)
  end

  def render_404
    render_error(404)
  end

protected

  def render_error(code)
    render :template => "shared/errors/#{code}", :status => :not_found
  end

end
