require 'spec_helper'

describe Contact do

  describe "class method" do

    describe "emails" do
      it "should find only active emails" do
        FactoryGirl.create(:contact)
        FactoryGirl.create(:contact, disabled: true, email: "false@example.com")
        Contact.emails.should eq(["test@example.com"])
      end

      it "should remove duplicates" do
        FactoryGirl.create(:contact)
        FactoryGirl.create(:contact)
        FactoryGirl.create(:contact)
        Contact.emails.should eq(["test@example.com"])
      end

      it "should handle an empty set" do
        Contact.emails.should eq([])
      end
    end

    describe "last_updated_at" do
      it "should get the last updated object" do
        contact = FactoryGirl.create(:contact)
        FactoryGirl.create(:contact)
        FactoryGirl.create(:contact)
        contact.update_attribute(:updated_at, Time.now + 1.day)
        contact.reload
        Contact.last_updated_at.should eq(contact.updated_at)
      end

      it "should handle nils" do
        Contact.last_updated_at.should be_nil
      end
    end

  end
end
