class TracksController < ApplicationController
  layout "player"

  def show
    @track = Track.find(params[:id])
    @tracks = Track.order("sort_order ASC")
  end

end

