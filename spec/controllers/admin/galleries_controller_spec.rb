require 'spec_helper'

describe Admin::GalleriesController do
  before(:each) do
    login_as_user
    @image = double(Image)
    @gallery = double(Gallery, :name => "delicious pie")
  end

  describe "GET index" do
    it "should load and assign all galleries" do
      Gallery.should_receive(:sorted).and_return([@gallery])
      get :index
      assigns(:galleries).should == [@gallery]
    end
  end

  describe "GET show" do
    before(:each) do
      @all_active_proxy = double
      @all = double
      Image.stub(:all_active => @all_active_proxy)
    end

    it "should set all the vars" do
      Gallery.should_receive(:find_by_name).with("pie").and_return(@gallery)
      get :show, :id => "pie"
      assigns(:title).should be_an_instance_of(String)
      assigns(:gallery).should == @gallery
    end
  end
end

