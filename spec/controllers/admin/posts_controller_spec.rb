require 'spec_helper'

describe Admin::PostsController do
  let(:the_post){ FactoryGirl.create(:post) }
  let(:post_attributes){ {"title" => "title"} }

  before(:each) do
    login_as_user
  end

  describe "GET index" do
    it "assigns all posts as @posts" do
      Post.stub(:page) { [the_post] }
      get :index
      assigns(:posts).should eq([the_post])
    end
  end

  describe "GET new" do
    it "assigns a new post as @post" do
      get :new
      assigns(:post).should be_an_instance_of(Post)
    end
  end

  describe "GET edit" do
    it "assigns the requested post as @post" do
      Post.stub(:find_by_permalink!).with("37") { the_post }
      get :edit, id: "37"
      assigns(:post).should be(the_post)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created post as @post" do
        the_post.stub(save: true)
        Post.stub(:new).with(post_attributes) { the_post }
        post :create, :post => post_attributes
        assigns(:post).should be(the_post)
      end

      it "redirects to the created post" do
        the_post.stub(save: true)
        Post.stub(:new) { the_post }
        post :create, post: post_attributes
        response.should redirect_to(admin_posts_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved post as @post" do
        the_post.stub(save: false)
        Post.stub(:new).with(post_attributes) { the_post }
        post :create, post: post_attributes
        assigns(:post).should be(the_post)
      end

      it "re-renders the 'new' template" do
        the_post.stub(save: false)
        Post.stub(:new) { the_post }
        post :create, post: post_attributes
        response.should render_template("new")
      end
    end
    
    describe "preview" do
      it "should render" do
        the_post.stub(:valid? => true)
        Post.stub(:new).with(post_attributes) { the_post }
        post :create, post: post_attributes, commit: "Preview"
        response.should render_template("edit")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested post" do
        Post.should_receive(:find_by_permalink!).with("37") { the_post }
        the_post.should_receive(:update_attributes).with(post_attributes)
        put :update, id: "37", post: post_attributes
      end

      it "assigns the requested post as @post" do
        the_post.stub(update_attributes: true)
        Post.stub(:find_by_permalink!) { the_post }
        put :update, id: "1", post: post_attributes
        assigns(:post).should be(the_post)
      end

      it "redirects to the post" do
        the_post.stub(update_attributes: true)
        Post.stub(:find_by_permalink!) { the_post }
        put :update, id: "1", post: post_attributes
        response.should redirect_to(admin_posts_url)
      end
    end

    describe "with invalid params" do
      it "assigns the post as @post" do
        the_post.stub(update_attributes: false)
        Post.stub(:find_by_permalink!) { the_post }
        put :update, id: "1", post: post_attributes
        assigns(:post).should be(the_post)
      end

      it "re-renders the 'edit' template" do
        the_post.stub(update_attributes: false)
        Post.stub(:find_by_permalink!) { the_post }
        put :update, id: "1", post: post_attributes
        response.should render_template("edit")
      end
    end

    describe "preview" do
      it "should check the commit and preview" do
        Post.stub(:find_by_permalink!) { the_post }
        the_post.should_receive(:attributes=)
        the_post.should_receive(:valid?)
        put :update, id: "1", commit: "Preview", post: post_attributes
        assigns(:post).should be(the_post)
        assigns(:preview).should be_true
      end
      
      it "should render" do
        the_post.stub(:attributes= => true, :valid? => nil)
        Post.stub(:find_by_permalink!) { the_post }
        put :update, id: "1", commit: "Preview", post: post_attributes
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested post" do
      Post.should_receive(:find_by_permalink!).with("37") { the_post }
      the_post.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the posts list" do
      Post.stub(:find_by_permalink!) { the_post }
      delete :destroy, id: "1"
      response.should redirect_to(admin_posts_url)
    end
  end

end
