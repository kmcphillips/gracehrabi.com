class Admin::EventsController < ApplicationController
  before_action :authenticate_user!, :set_objects

  def index
    @events = Event.order("starts_at DESC").page(params[:page])
  end

  def new
    if source = Event.find_by_id(params[:source])
      @event = source.dup
    else
      @event = Event.new
    end
  end

  def edit
  end

  def create
    @event = Event.new(event_params)

    if params[:commit] == "Preview"
      @event.valid?
      @preview = true
      render action: "edit"
    elsif @event.save
      redirect_to(admin_events_url, notice: 'Event was successfully created.')
    else
      render action: "new"
    end
  end

  def update
    if params[:commit] == "Preview"
      @event.attributes = event_params
      @event.valid?
      @preview = true
      render action: "edit"
    elsif @event.update_attributes(event_params)
       redirect_to(admin_events_url, notice: 'Event was successfully updated.')
    else
      render action: "edit"
    end
  end

  def destroy
    @event.destroy

     redirect_to(admin_events_url)
  end

  private

  def set_objects
    @event = Event.find(params[:id]) if params[:id]
  end

  def event_params
    params.require(:event).permit(:title, :description, :publicized, :starts_at, :price, :image, :clear_image, :previous_image_id)
  end

end
