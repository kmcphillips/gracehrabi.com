class TracksController < ApplicationController
  layout "player"

  def show
    @track = Track.find(params[:id])
  end

end

