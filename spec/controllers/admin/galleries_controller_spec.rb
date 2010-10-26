require 'spec_helper'

describe Admin::GalleriesController do
  before(:each) do
    login_as_mock_user
    @image = mock_model(Image)
    @all_active_proxy = mock(:all_active)
    @all_active_proxy.stub(:for_gallery).and_return([@image])
  end

  describe "GET index" do
    it "should assign the hash of galleries" do
      Image.stub(:all_active).and_return(@all_active_proxy)

      # do this in a different and less awesome way to show that it gives the same result
      result = {}
      Image::GALLERIES.keys.each do |k|
        result[k] = [@image]
      end

      get :index
      assigns(:galleries).should == result
    end
  end
end

