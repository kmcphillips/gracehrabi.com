require "spec_helper"

describe TracksController do
  describe "routing" do

    it "recognizes and generates player #index" do
      { :get => "/player" }.should route_to(:controller => "tracks", :action => "index")
    end

    it "recognizes and generates player #index" do
      { :get => "/player/1" }.should route_to(:controller => "tracks", :action => "show", :id => "1")
    end

  end
end
