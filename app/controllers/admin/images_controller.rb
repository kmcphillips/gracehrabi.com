class Admin::ImagesController < ApplicationController
  before_filter :require_login

  def create
    image = Image.new(params[:image])

    if image.save
      flash[:notice] = 'Image was successfully added.'
    else
      flash[:error] = image.errors.full_messages.to_sentence
    end

    if image.gallery
      redirect_to admin_gallery_path(image.gallery)
    else
      redirect_to admin_galleries_path
    end
  end

  def update
    image = Image.find(params[:id])

    if image.update_attributes(params[:image])
      flash[:notice] = "Image updated."
    else
      flash[:error] = image.errors.full_messages.to_sentence
    end

    if image.gallery
      redirect_to admin_gallery_path(image.gallery)
    else
      redirect_to admin_galleries_path
    end
  end

  def destroy
    image = Image.find(params[:id])
    image.destroy
    
    if image.gallery
      redirect_to admin_gallery_path(image.gallery)
    else
      redirect_to admin_galleries_path
    end
  end

end

