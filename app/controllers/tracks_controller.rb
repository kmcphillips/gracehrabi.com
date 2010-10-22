class TracksController < ApplicationController
  layout "player"

  def index
    @tracks = Track.order("sort_order ASC")
  end

  def show
    @track = Track.find(params[:id])
  end

end
