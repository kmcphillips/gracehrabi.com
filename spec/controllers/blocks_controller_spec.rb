require 'spec_helper'

describe BlocksController do
  let(:block){ FactoryGirl.create(:block) }
  let(:scope){ double }

  describe "GET about" do
    it "assigns the requested block as @block" do
      expect(Block).to receive(:find_by_label).with("about").and_return(block)
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

  describe "GET gallery" do
    it "should should get the gallery" do
      expect(Image).to receive(:all_active).and_return(scope)
      expect(scope).to receive(:in_order).and_return(scope)
      get :gallery
      expect(response).to render_template(:gallery)
      expect(assigns(:images)).to eq(scope)
    end
  end

end
