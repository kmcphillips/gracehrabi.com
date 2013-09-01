require 'spec_helper'

describe Admin::ImagesController do
  let(:image){ FactoryGirl.create(:image) }

  before(:each) do
    login_as_user
    @gallery = Gallery.create! :name => "Publicity", :path => "publicity", :image => "gallery1.png", :sort_order => 0

    @valid_attributes = {
      :gallery_id => @gallery.id,
      :file_file_name => "test.jpg",
      :file_content_type => "image/jpg",
      :file_file_size => "12345",
      :file_updated_at => Time.now,
      :file_fingerprint => "123094123092093"
      }
  end

  describe "POST create" do

    describe "with valid params" do
      it "redirects to the created post" do
        image.stub(:save => true, :gallery => @gallery)
        Image.stub(:new) { image }
        post :create, :image => @valid_attributes
        response.should redirect_to(admin_gallery_path(@gallery, anchor: 'form'))
      end
    end

    describe "with invalid params" do
      it "redirects and errors" do
        image.stub(:save => false, :gallery => @gallery)
        Image.stub(:new) { image }
        post :create, :image => @valid_attributes
        response.should redirect_to(admin_gallery_path(@gallery, anchor: 'form'))
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested image" do
      Image.should_receive(:find).with("37") { image }
      image.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the image list" do
      image.stub(:gallery => "pie")
      Image.stub(:find) { image }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_gallery_path("pie"))
    end
  end

  describe "POST sort" do
    before(:each) do
      @i1 = Image.create! @valid_attributes
      @i2 = Image.create! @valid_attributes
      @i3 = Image.create! @valid_attributes
    end

    it "should sort the IDs passed back" do
      post :sort, :image => [@i3.id, @i1.id, @i2.id]
      Image.in_order.map(&:id).should == [@i3.id, @i1.id, @i2.id]
    end

    after(:each) do
      Image.destroy_all
      Gallery.destroy_all
    end
  end
end

