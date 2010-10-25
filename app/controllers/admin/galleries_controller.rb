class Admin::GalleriesController < GalleriesController
  before_filter :require_login

end

