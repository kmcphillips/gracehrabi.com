require 'spec_helper'

describe GalleriesController do
  before(:each) do
    @image = mock_model(Image)
  end

  describe "GET index" do
    it "should load and that's about it" do
      get :index
      response.should be_successful
    end
  end

  describe "GET show" do
    before(:each) do
      @all_active_proxy = mock :all_active
      @all = mock :all
      Image.stub(:all_active => @all_active_proxy)
    end

    it "should set all the vars" do
      gallery = Image::GALLERIES.keys.first.to_s
      @all_active_proxy.should_receive(:for_gallery).with(gallery).and_return(@all)
      @all.should_receive(:in_order).and_return([@image])
      get :show, :id => gallery
      assigns(:images).should == [@image]
      assigns(:gallery).should == gallery
      assigns(:gallery_name).should == Image::GALLERIES[gallery] 
    end
  end
end
