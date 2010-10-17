require "spec_helper"

describe TracksController do
  describe "routing" do

    it "recognizes and generates player #index" do
      { :get => "/player" }.should route_to(:controller => "tracks", :action => "index")
    end

  end
end
