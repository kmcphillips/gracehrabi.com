require 'spec_helper'

describe Admin::TracksController do
  before(:each) do
    login_as_user
  end

  def mock_track(stubs={})
    @mock_track ||= mock_model(Track, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all tracks as @tracks" do
      Track.stub(:order) { [mock_track] }
      get :index
      assigns(:tracks).should eq([mock_track])
    end
  end

  describe "GET new" do
    it "assigns a new track as @track" do
      Track.stub(:new) { mock_track }
      get :new
      assigns(:track).should be(mock_track)
    end
  end

  describe "GET edit" do
    it "assigns the requested track as @track" do
      Track.stub(:find).with("37") { mock_track }
      get :edit, :id => "37"
      assigns(:track).should be(mock_track)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created track as @track" do
        Track.stub(:new).with({'these' => 'params'}) { mock_track(:save => true) }
        post :create, :track => {'these' => 'params'}
        assigns(:track).should be(mock_track)
      end

      it "redirects to the created track" do
        Track.stub(:new) { mock_track(:save => true) }
        post :create, :track => {}
        response.should redirect_to(admin_tracks_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved track as @track" do
        Track.stub(:new).with({'these' => 'params'}) { mock_track(:save => false) }
        post :create, :track => {'these' => 'params'}
        assigns(:track).should be(mock_track)
      end

      it "re-renders the 'new' template" do
        Track.stub(:new) { mock_track(:save => false) }
        post :create, :track => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested track" do
        Track.should_receive(:find).with("37") { mock_track }
        mock_track.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :track => {'these' => 'params'}
      end

      it "assigns the requested track as @track" do
        Track.stub(:find) { mock_track(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:track).should be(mock_track)
      end

      it "redirects to the track" do
        Track.stub(:find) { mock_track(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_tracks_url)
      end
    end

    describe "with invalid params" do
      it "assigns the track as @track" do
        Track.stub(:find) { mock_track(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:track).should be(mock_track)
      end

      it "re-renders the 'edit' template" do
        Track.stub(:find) { mock_track(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested track" do
      Track.should_receive(:find).with("37") { mock_track }
      mock_track.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the tracks list" do
      Track.stub(:find) { mock_track }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_tracks_url)
    end
  end

end
