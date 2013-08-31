class Admin::EventsController < ApplicationController
  before_action :require_login, :set_objects

  def index
    @events = Event.paginate(pagination_params(:order => "created_at DESC"))
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
    @event = Event.new(params[:event])

    if params[:commit] == "Preview"
      @event.valid?
      @preview = true
      render :action => "edit"
    elsif @event.save
      redirect_to(admin_events_url, :notice => 'Event was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if params[:commit] == "Preview"
      @event.attributes = params[:event]
      @event.valid?
      @preview = true
      render :action => "edit"
    elsif @event.update_attributes(params[:event])
       redirect_to(admin_events_url, :notice => 'Event was successfully updated.')
    else
      render :action => "edit"
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
end
