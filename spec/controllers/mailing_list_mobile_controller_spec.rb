require "spec_helper"

describe MailingListMobileController do
  let(:contact){ FactoryGirl.create(:contact) }
  let(:email){ contact.email }
  
  describe "GET index" do
    it "should render the default template" do
      get :index
      response.should render_template(:index)
      assigns(:title).should_not be_blank
    end
    
    it "should render the mobile layout" do
      get :index
      response.should render_template('layouts/mobile')
    end
  end
  
  describe "POST create" do
    it "should redirect on success" do
      Contact.should_receive(:build_from_email).with(email).and_return(contact)
      contact.should_receive(:save).and_return(true)
      
      post :create, email: email
      
      response.should redirect_to(mailing_list_mobile_index_path)
      flash[:notice].should_not be_blank
      flash[:error].should be_blank
      assigns(:contact).should eq(contact)
    end
    
    it "should render on failure" do
      Contact.should_receive(:build_from_email).with(email).and_return(contact)
      contact.should_receive(:save).and_return(false)
      
      post :create, email: email
      
      response.should render_template(:index)
      flash[:error].should_not be_blank
      flash[:notice].should be_blank
      assigns(:contact).should eq(contact)
    end
  end
  
end
