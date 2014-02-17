require 'spec_helper'

describe BlocksController do
  let(:block){ FactoryGirl.create(:block) }

  describe "GET about" do
    it "assigns the requested block as @block" do
      Block.stub(:find_by_label).with("about") { block }
      get :about
      expect(assigns(:block)).to eq(block)
    end
  end
  
  describe "GET home" do
    it "should render the template" do
      get :home
      expect(response).to render_template(:home)
    end
  end

end
