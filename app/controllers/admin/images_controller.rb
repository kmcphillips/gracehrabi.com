class Admin::ImagesController < ApplicationController
  before_action :authenticate_user!

  def create
    image = Image.new(image_params)

    if image.save
      flash[:notice] = 'Image was successfully added.'
    else
      flash[:error] = image.errors.full_messages.to_sentence
    end

    if image.gallery
      redirect_to admin_gallery_path(image.gallery, anchor: "form")
    else
      redirect_to admin_galleries_path
    end
  end

  def update
    image = Image.find(params[:id])

    if image.update_attributes(image_params)
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
    gallery = image.try(:gallery)
    image.destroy

    if gallery
      redirect_to admin_gallery_path(gallery)
    else
      redirect_to admin_galleries_path
    end
  end

  def sort
    if params[:image].try(:is_a?, Array)
      params[:image].each_with_index do |id, index|
        ActiveRecord::Base.connection.execute("UPDATE images SET sort_order = #{index + 1} WHERE id = #{id.to_i}")
      end
    end

    render nothing: true
  end

  private

  def image_params
    params.require(:image).permit(:file, :label, :gallery_id)
  end

end

