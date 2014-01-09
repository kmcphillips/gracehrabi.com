require 'spec_helper'

describe BlocksController do
  let(:block){ FactoryGirl.create(:block) }

  describe "GET bio" do
    it "assigns the requested block as @block" do
      Block.stub(:find_by_label).with("bio") { block }
      get "bio"
      assigns(:block).should be(block)
    end
  end
  
  describe "GET home" do
    it "should render the template" do
      get :home
      response.should render_template(:home)
    end
  end

end
