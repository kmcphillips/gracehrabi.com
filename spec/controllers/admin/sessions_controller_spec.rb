require 'spec_helper'

describe Admin::SessionsController do

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  describe "GET new" do
    it "should redirect if you are already logged in" do
      controller.current_user(mock_model(User))
      get :new
      response.should redirect_to("/admin")
    end
    
    it "should just be cool if you want to login" do
      get :new
      response.should_not redirect_to("/admin")
    end
  end

  describe "POST create" do
    it "should authenticate" do
      User.should_receive(:authenticate).and_return(mock_model(User))
      post :create
      response.should redirect_to("/admin")
    end

    it "should not authenticate" do
      User.should_receive(:authenticate)
      post :create
      response.should redirect_to("/admin/login")
    end
  end

  describe "POST logout" do
    it "should clear the current user" do
      controller.current_user(mock_model(User))
      post :logout
      flash[:notice].should_not be_blank
    end
    
    it "should not flash if you are not logged in" do
      post :logout
      flash[:notice].should be_blank
    end
  end

end
