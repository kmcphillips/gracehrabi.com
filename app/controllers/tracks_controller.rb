class TracksController < ApplicationController
  layout "player"

  def index
    @tracks = Track.all
  end

  def show
    @track = Track.find(params[:id])
  end

end
