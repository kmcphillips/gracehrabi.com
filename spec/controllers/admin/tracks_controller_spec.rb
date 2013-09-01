require 'spec_helper'

describe Admin::TracksController do
  let(:track){ FactoryGirl.create(:track) }
  let(:track_attributes){ {} }

  before(:each) do
    login_as_user
  end

  describe "GET index" do
    it "assigns all tracks as @tracks" do
      Track.stub(:order) { [track] }
      get :index
      assigns(:tracks).should eq([track])
    end
  end

  describe "GET new" do
    it "assigns a new track as @track" do
      get :new
      assigns(:track).should be_an_instance_of(Track)
    end
  end

  describe "GET edit" do
    it "assigns the requested track as @track" do
      Track.stub(:find).with("37") { track }
      get :edit, id: "37"
      assigns(:track).should be(track)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created track as @track" do
        track.stub(save: true)
        Track.stub(:new).with(track_attributes) { track }
        post :create, track: track_attributes
        assigns(:track).should be(track)
      end

      it "redirects to the created track" do
        track.stub(save: true)
        Track.stub(:new) { track }
        post :create, track: track_attributes
        response.should redirect_to(admin_tracks_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved track as @track" do
        track.stub(save: false)
        Track.stub(:new).with(track_attributes) { track }
        post :create, track: track_attributes
        assigns(:track).should be(track)
      end

      it "re-renders the 'new' template" do
        track.stub(save: false)
        Track.stub(:new) { track }
        post :create, track: track_attributes
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested track" do
        Track.should_receive(:find).with("37") { track }
        track.should_receive(:update_attributes).with(track_attributes)
        put :update, id: "37", track: track_attributes
      end

      it "assigns the requested track as @track" do
        track.stub(update_attributes: true)
        Track.stub(:find) { track }
        put :update, id: "1", track: track_attributes
        assigns(:track).should be(track)
      end

      it "redirects to the track" do
        track.stub(update_attributes: true)
        Track.stub(:find) { track }
        put :update, id: "1", track: track_attributes
        response.should redirect_to(admin_tracks_url)
      end
    end

    describe "with invalid params" do
      it "assigns the track as @track" do
        track.stub(update_attributes: false)
        Track.stub(:find) { track }
        put :update, id: "1", track: track_attributes
        assigns(:track).should be(track)
      end

      it "re-renders the 'edit' template" do
        track.stub(update_attributes: false)
        Track.stub(:find) { track }
        put :update, id: "1", track: track_attributes
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested track" do
      Track.should_receive(:find).with("37") { track }
      track.should_receive(:destroy)
      delete :destroy, id: "37"
    end

    it "redirects to the tracks list" do
      Track.stub(:find) { track }
      delete :destroy, id: "1"
      response.should redirect_to(admin_tracks_url)
    end
  end

end
