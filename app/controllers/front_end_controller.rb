class FrontEndController < ApplicationController
  include StagingAuthentication

  protected

  def current_testimonial
    @current_testimonial ||= Testimonial.random
  end
  helper_method :current_testimonial
end
