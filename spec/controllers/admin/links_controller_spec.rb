require 'spec_helper'

describe Admin::LinksController do
  let(:link){ FactoryGirl.create(:link) }
  let(:link_attributes){ {'title' => "title", 'url' => "http://example.com"} }

  before(:each) do
    login_as_user
  end

  describe "GET index" do
    it "assigns all links as @links" do
      Link.stub(:in_order) { [link] }
      get :index
      assigns(:links).should eq([link])
    end
  end

  describe "GET new" do
    it "assigns a new link as @link" do
      get :new
      assigns(:link).should be_an_instance_of(Link)
    end
  end

  describe "GET edit" do
    it "assigns the requested link as @link" do
      Link.stub(:find).with("37") { link }
      get :edit, id: "37"
      assigns(:link).should be(link)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created link as @link" do
        link.stub(save: true)
        Link.stub(:new).with(link_attributes) { link }
        post :create, link: link_attributes
        assigns(:link).should be(link)
      end

      it "redirects to the created link" do
        link.stub(save: true)
        Link.stub(:new) { link }
        post :create, link: link_attributes
        response.should redirect_to(admin_links_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved link as @link" do
        link.stub(save: false)
        Link.stub(:new).with(link_attributes) { link }
        post :create, link: link_attributes
        assigns(:link).should be(link)
      end

      it "re-renders the 'new' template" do
        link.stub(save: false)
        Link.stub(:new) { link }
        post :create, link: link_attributes
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested link" do
        Link.should_receive(:find).with("37") { link }
        link.should_receive(:update_attributes).with(link_attributes)
        put :update, id: "37", link: link_attributes
      end

      it "assigns the requested link as @link" do
        link.stub(update_attributes: true)
        Link.stub(:find) { link }
        put :update, id: "1", link: link_attributes
        assigns(:link).should be(link)
      end

      it "redirects to the link" do
        link.stub(update_attributes: true)
        Link.stub(:find) { link }
        put :update, id: "1", link: link_attributes
        response.should redirect_to(admin_links_url)
      end
    end

    describe "with invalid params" do
      it "assigns the link as @link" do
        link.stub(update_attributes: false)
        Link.stub(:find) { link }
        put :update, id: "1", link: link_attributes
        assigns(:link).should be(link)
      end

      it "re-renders the 'edit' template" do
        link.stub(update_attributes: false)
        Link.stub(:find) { link }
        put :update, id: "1", link: link_attributes
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested link" do
      Link.should_receive(:find).with("37") { link }
      link.should_receive(:destroy)
      delete :destroy, id: "37"
    end

    it "redirects to the links list" do
      Link.stub(:find) { link }
      delete :destroy, id: "1"
      response.should redirect_to(admin_links_url)
    end
  end

end
