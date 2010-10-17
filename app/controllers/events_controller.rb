class EventsController < ApplicationController

  def index
    @upcoming = Event.upcoming
    @current = Event.current
    @past = Event.past
  end

  def show
    @event = Event.find(params[:id])
  end

end
