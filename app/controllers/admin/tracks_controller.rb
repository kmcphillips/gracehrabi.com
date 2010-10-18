class Admin::TracksController < ApplicationController
  
  def index
    @tracks = Track.all
  end

  def new
    @track = Track.new
  end

  def edit
    @track = Track.find(params[:id])
  end

  def create
    @track = Track.new(params[:track])

    if @track.save
      redirect_to(admin_tracks_path, :notice => 'Track was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @track = Track.find(params[:id])
    
    if @track.update_attributes(params[:track])
      redirect_to(admin_tracks_path, :notice => 'Track was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy

    redirect_to(admin_tracks_url)
  end
end

