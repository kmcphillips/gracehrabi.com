require 'spec_helper'

describe EventsController do
  let(:event){ FactoryGirl.create(:event) }

  describe "GET index" do
    it "assigns all events as @events" do
      Event.stub(upcoming: "upcoming", current: "current")
      get :index
      assigns(:upcoming).should eq("upcoming")
      assigns(:current).should eq("current")
    end
  end

  describe "GET show" do
    it "assigns the requested event as @event" do
      Event.stub(:find).with("37") { event }
      get :show, id: "37"
      assigns(:event).should be(event)
    end
  end

  describe "GET archive" do
    it "assigns all past events as @past" do
      Event.stub(past: double(:past, order: "past"))
      get :archive
      assigns(:past).should eq("past")
    end
  end
end
