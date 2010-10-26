require 'spec_helper'

describe Admin::ImagesController do
  before(:each) do
    login_as_mock_user
  end  

  def mock_image(stubs={})
    @mock_image ||= mock_model(Image, stubs).as_null_object
  end

  describe "POST create" do

    describe "with valid params" do
      it "redirects to the created post" do
        Post.stub(:new) { mock_image(:save => true) }
        post :create, :image => {}
        response.should redirect_to(admin_galleries_path)
      end
    end

    describe "with invalid params" do
      it "redirects and errors" do
        Post.stub(:new) { mock_image(:save => false) }
        post :create, :image => {}
        response.should redirect_to(admin_galleries_path)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested image" do
      Image.should_receive(:find).with("37") { mock_image }
      mock_image.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the image list" do
      Image.stub(:find) { mock_image(:gallery => "pie") }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_gallery_path("pie"))
    end
  end

end

