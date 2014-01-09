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
    
    it "should get the objects for the different portlets" do
      events = [double]
      posts = [double]
      images = [double]
      Image.should_receive(:random_sample).and_return(images)
      Event.should_receive(:current_and_upcoming).and_return(events)
      events.should_receive(:limit).with(5).and_return(events)
      Post.should_receive(:recent).and_return(posts)
      
      get :home
      
      assigns(:events).should eq(events)
      assigns(:posts).should eq(posts)
      assigns(:images).should eq(images)
    end
  end

end
