class GalleriesController < ApplicationController

  def index
  end

  def show
    @images = Image.all_active.for_gallery(params[:id])
    @gallery = params[:id]
    @gallery_name = Image::GALLERIES[params[:id]] || "Unknown"
  end

end

