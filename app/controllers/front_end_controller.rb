class FrontEndController < ApplicationController
  include StagingAuthentication

  protected

  def current_testimonial
    @current_testimonial ||= Testimonial.random
  end

  def upcoming_events
    @upcoming_events ||= Event.front_end_upcoming
  end

  def recent_posts
    @recent_posts ||= Post.recent
  end

  helper_method :current_testimonial, :upcoming_events, :recent_posts
end
