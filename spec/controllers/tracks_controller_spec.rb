require 'spec_helper'

describe TracksController do

  let(:track){ double(Track) }

  describe "GET show" do
    it "assigns the requested track as @track" do
      Track.stub(:find).with("37") { track }
      Track.stub(:order) { [track] }
      get :show, :id => "37"
      assigns(:track).should be(track)
      assigns(:tracks).should == [track]
    end
  end

end
