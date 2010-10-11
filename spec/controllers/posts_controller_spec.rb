require 'spec_helper'

describe PostsController do

  def mock_post(stubs={})
    @mock_post ||= mock_model(Post, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all posts as @posts" do
      Post.stub(:all) { [mock_post] }
      get :index
      assigns(:posts).should eq([mock_post])
    end
  end

  describe "GET show" do
    it "assigns the requested post as @post" do
      Post.stub(:find).with("37") { mock_post }
      get :show, :id => "37"
      assigns(:post).should be(mock_post)
    end
  end

  describe "GET rss.xml" do
    it "should get all posts" do
      pending "I don't know how to test Arel yet"
    end
  end
end
