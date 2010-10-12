require "spec_helper"

describe BlocksController do
  describe "routing" do

    it "recognizes and generates #about" do
      { :get => "/about" }.should route_to(:controller => "blocks", :action => "about")
    end
      it "recognizes and generates #contact" do
        { :get => "/contact" }.should route_to(:controller => "blocks", :action => "contact")
      end

  end
end