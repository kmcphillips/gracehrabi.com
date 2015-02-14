require 'spec_helper'

describe BlocksController do
  let(:block){ FactoryGirl.create(:block) }
  let(:scope){ double }

  describe "GET media" do
    it "renders correctly" do
      get :media
      expect(response).to render_template(:media)
      expect(assigns(:title)).to be_present
    end
  end

  describe "GET home" do
    it "should render the template" do
      expect(Block).to receive(:find_by_label).with("about").and_return(block)
      expect(Block).to receive(:find_by_label).with("home").and_return(nil)
      get :home
      expect(response).to render_template(:home)
      expect(assigns(:about)).to eq(block)
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
