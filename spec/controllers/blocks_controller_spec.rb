require 'spec_helper'

describe BlocksController do

  def mock_block(stubs={})
    @mock_block ||= mock_model(Block, stubs).as_null_object
  end

  describe "GET contact" do
    it "assigns the requested block as @block" do
      Block.stub(:find_by_label).with("contact") { mock_block }
      get "contact"
      assigns(:block).should be(mock_block)
    end
  end

  describe "GET bio" do
    it "assigns the requested block as @block" do
      @media = mock_model(Media)
      Block.stub(:find_by_label).with("bio") { mock_block }
      Media.stub(:find_by_label! => @media)
      get "bio"
      assigns(:block).should be(mock_block)
      assigns(:kit).should be(@media)
    end
  end

  describe "GET links" do
    it "assigns the requested block as @block" do
      Block.stub(:find_by_label).with("links")
      Link.should_receive(:in_order).and_return(["links"])
      get "links"
      assigns(:block).should be(nil)
      assigns(:links).should == ["links"]
    end
  end
  
  describe "GET home" do
    it "should render the template" do
      get :home
      response.should render_template(:home)
    end
    
    it "should get the objects for the different portlets" do
      events = [mock]
      posts = [mock]
      images = [mock]
      Image.should_receive(:random_sample).and_return(images)
      Event.should_receive(:upcoming).and_return(events)
      events.should_receive(:limit).with(5).and_return(events)
      Post.should_receive(:recent).and_return(posts)
      
      get :home
      
      assigns(:events).should eq(events)
      assigns(:posts).should eq(posts)
      assigns(:images).should eq(images)
    end
  end

end
