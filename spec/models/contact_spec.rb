require 'spec_helper'

describe Contact do
  let(:email){ "example@example.com" }
  let(:contact){ Contact.create!(email: email) }
  let(:contact2){ Contact.create!(email: "example2@example.com") }
  
  describe "#disable" do
    it "should disable the enabled contact" do
      contact.disabled?.should be_false
      contact.disable
      contact.disabled?.should be_true
    end
  end
  
  describe "#enabled" do
    it "should be the oposite of #disabled" do
      contact.enabled.should eq(!contact.disabled)
      contact.update_attribute(:disabled, !contact.disabled)
      contact.enabled.should eq(!contact.disabled)
    end
  end
  
  describe "#set_token" do
    it "should set the token to something random" do
      contact = Contact.new email: email
      contact.token.should be_nil
      contact.save!
      contact.token.should ~= /^[0-9abcdef]{32}$/
    end
    
    it "should not reset the token if it has already been set" do
      contact = Contact.new email: email, token: "pie"
      contact.save!
      contact.token.should eq("pie")
    end
  end
  
  describe "class method" do
    describe "#emails" do
      it "should find all active unique emails" do
        contact
        contact2
        Contact.create!(email: "example3@example.com", disabled: true)
        
        Contact.emails.sort.should eq([contact.email, contact2].sort)
      end
    end

    describe "#last_updated_at" do
      it "should find the updated at of the last contact" do
        contact
        contact2.update_attribute(:updated_at, Time.now - 1.year)
        
        Contact.last_updated_at.should eq(contact.updated_at)
      end
      
      it "should handle an empty list" do
        Contact.last_updated_at.should be_nil
      end
    end
  end
end
