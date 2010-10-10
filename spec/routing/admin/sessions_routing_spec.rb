require "spec_helper"

describe SessionsController do
  describe "routing" do

    it "recognizes and generates #new" do
      { :get => "/admin/login" }.should route_to(:controller => "sessions", :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/sessions" }.should route_to(:controller => "sessions", :action => "create")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/logout" }.should route_to(:controller => "sessions", :action => "logout")
    end

  end
end
