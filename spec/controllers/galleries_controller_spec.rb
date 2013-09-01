require 'spec_helper'

describe GalleriesController do
  let(:image){ FactoryGirl.create(:image) }
  let(:gallery){ FactoryGirl.create(:gallery) }

  describe "GET index" do
    it "should load and assign all galleries" do
      Gallery.should_receive(:sorted).and_return([gallery])
      get :index
      assigns(:galleries).should eq([gallery])
    end
  end

  describe "GET show" do
    it "should set all the vars" do
      Image.stub(all_active: double)
      Gallery.should_receive(:find_by_path).with("pie").and_return(gallery)
      get :show, :id => "pie"
      assigns(:title).should be_an_instance_of(String)
      assigns(:gallery).should eq(gallery)
    end
  end
end
