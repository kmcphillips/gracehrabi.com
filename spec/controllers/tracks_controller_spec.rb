require 'spec_helper'

describe TracksController do

  def mock_track(stubs={})
    @mock_track ||= mock_model(Track, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all tracks as @tracks" do
      Track.stub(:all) { [mock_track] }
      get :index
      assigns(:tracks).should eq([mock_track])
    end
  end


end
