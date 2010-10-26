class Admin::GalleriesController < GalleriesController
  before_filter :require_login

  def index
    @galleries = Image::GALLERIES.keys.inject({}){|acc, key| acc.merge(key => Image.all_active.for_gallery(key)) }
  end

end
