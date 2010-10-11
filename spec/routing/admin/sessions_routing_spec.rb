require "spec_helper"

describe Admin::SessionsController do
  describe "routing" do

    it "recognizes and generates #new" do
      { :get => "/admin/login" }.should route_to(:controller => "admin/sessions", :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/sessions" }.should route_to(:controller => "admin/sessions", :action => "create")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/logout" }.should route_to(:controller => "admin/sessions", :action => "logout")
    end

  end
end
