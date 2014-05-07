require "spec_helper"

describe Admin::ContactsController do
  before(:each) do
    login_as_user
  end
  
  describe "GET index" do
    it "should render the default template" do
      get :index
      response.should render_template(:index)
    end

    it "should search if the search term is present" do
      test = Contact.create!(email: "test@example.com")
      Contact.create!(email: "example@example.com")
      get :index, search: "test"
      assigns[:contacts].should eq([test])
    end
  end
  
  describe "POST create" do
    it "should add bulk emails, flash, and redirect" do
      Contact.should_receive(:add_bulk).with("emails").and_return(314)
      post :create, emails: "emails"
      flash[:notice].should eq("Added 314 email addresses.")
      response.should redirect_to(admin_contacts_path)
    end
  end
end
