require "spec_helper"

describe MailingListController do
  let(:email){ "example@example.com" }
  let(:token){ contact.token }
  let(:contact){ Contact.create!(email: email) }
  
  describe "GET index" do
    it "should render the default template" do
      get :index
      response.should render_template(:index)
    end
    
    it "should set the title" do
      get :index
      assigns[:title].should eq("Mailing list sign up")
    end
  end
  
  describe "POST create" do
    context "success" do
      it "should create a new contact" do
        Contact.conut.should eq(0)
        post :create, email: email
        flash[:notice].should_not be_blank
        assigns[:contact].email.should eq(email)
        assigns[:contact].should_not be_new_record
        Contact.count.should eq(1)
      end
      
      it "should find the existing contact and enable it" do
        contact = Contact.create!(email: email, disabled: true)
        post :create, email: email
        flash[:notice].should_not be_blank
        assigns[:contact].email.should eq(contact)
        assigns[:contact].disabled.should be_false
      end
      
      it "should render index" do
        post :create, email: email
        response.should render_template(:index)
      end
    end
    
    context "failure" do
      it "should render index" do
        post :create
        response.should render_template(:index)
        flash[:notice].should be_blank
      end
    end
  end
  
  describe "GET show" do
    it "should render the default template" do
      get :show, id: contact.token
      response.should render_template(:show)
    end
    
    it "should set the contact and title" do
      get :show, id: contact.token
      assigns[:title].should eq("Unsubscribe")
      assigns[:contact].should eq(contact)
    end
  end
  
  describe "DELETE destroy" do
    it "should render the default template" do
      delete :destroy, id: contact.token
      response.should render_template(:destroy)
    end
    
    it "should destroy the contact if found" do
      delete :destroy, id: contact.token
      assigns[:title].should eq("Unsubscribe success")
      Contact.find_by_token(contact.token).should be_nil
    end
    
    it "should raise if the contact is not found" do
      lambda{ delete :destroy }.should raise_error(ActiveRecord::NotFound) # TODO
    end
  end
  
end
