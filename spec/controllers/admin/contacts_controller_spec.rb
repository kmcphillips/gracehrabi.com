require "spec_helper"

describe Admin::ContactsController do
  before(:each) do
    login_as_mock_user
  end
  
  describe "GET index" do
    it "should render the default template" do
      get :index
      response.should render_template(:index)
    end
    
    it "should get a list of contacts and set the title" do
      contacts = [mock]
      emails = mock
      date = mock
      Contact.should_receive(:paginate).and_return(contacts)
      Contact.should_receive(:emails).and_return(emails)
      Contact.should_receive(:last_updated_at).and_return(date)
      get :index
      assigns[:title].should_not be_blank
      assigns[:contacts].should eq(contacts)
      assigns[:emails].should eq(emails)
      assigns[:date].should eq(date)
    end
  end
  
  describe "PUT update" do
    
  end
end
