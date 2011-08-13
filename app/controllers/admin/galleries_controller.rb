class Admin::GalleriesController < ApplicationController
  before_filter :require_login

  def index
    @galleries = Gallery.sorted
  end

  def show
    @gallery = Gallery.find_by_name(params[:id])
    @title = "Gallery - #{@gallery.name}"
  end

end
