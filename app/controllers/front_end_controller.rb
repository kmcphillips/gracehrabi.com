class FrontEndController < ApplicationController
  include StagingAuthentication

  protected

  def current_testimonial
    @current_testimonial ||= Testimonial.random
  end
end
