class GalleriesController < ApplicationController

  def index
  end

  def show
    @images = Image.all_active.for_gallery(params[:id]).in_order
    @gallery = params[:id]
    @gallery_name = Image::GALLERIES[params[:id]] || "Unknown"
    @title = "Gallery - #{@gallery_name}"
  end

end

