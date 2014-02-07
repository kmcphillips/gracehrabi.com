class EventsController < ApplicationController

  def index
    @upcoming = Event.upcoming
    @current = Event.current
    @calendar = EventCalendar.new(params[:month], params[:year])
  end

  def show
    @event = Event.find(params[:id])
  end

  def archive
    @past = Event.past.order("starts_at DESC")
  end

end
