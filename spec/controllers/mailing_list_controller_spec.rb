require "spec_helper"

describe MailingListController do
  let(:email){ "example@example.com" }
  let(:token){ contact.token }
  let(:contact){ FactoryGirl.create(:contact, email: email) }

  before(:each) do
    request.env["HTTP_REFERER"] = "http://test.host/"
  end

  describe "POST create" do
    context "success" do
      it "should create a new contact" do
        Contact.count.should eq(0)
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
        flash[:error].should be_blank
        assigns[:contact].email.should eq(contact.email)
        assigns[:contact].disabled.should be_falsey
      end

      it "should render index" do
        post :create, email: email
        response.should redirect_to(root_path)
      end
    end

    context "failure" do
      it "should render index" do
        post :create
        response.should redirect_to(:back)
        flash[:notice].should be_blank
        flash[:error].should_not be_blank
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
      Contact.find_by_token_and_disabled(contact.token, false).should be_nil
    end

    it "should raise if the contact is not found" do
      contact.disable
      lambda{ delete :destroy, id: contact.token }.should raise_error(ActiveRecord::RecordNotFound)
    end
  end

end
