require 'spec_helper'

describe EventsController do

  let(:event){ double(Event) }

  describe "GET index" do
    it "assigns all events as @events" do
      Event.stub(:upcoming => "upcoming", :current => "current", :past => double(:past, :order => "past"))
      get :index
      assigns(:upcoming).should eq("upcoming")
      assigns(:current).should eq("current")
      assigns(:past).should eq("past")
    end
  end

  describe "GET show" do
    it "assigns the requested event as @event" do
      Event.stub(:find).with("37") { event }
      get :show, :id => "37"
      assigns(:event).should be(event)
    end
  end
end
