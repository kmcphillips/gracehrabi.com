require 'spec_helper'

describe Contact do
  let(:email){ "example@example.com" }
  let(:contact){ Contact.create!(email: email) }
  let(:contact2){ Contact.create!(email: "example2@example.com") }

  describe "#disable" do
    it "should disable the enabled contact" do
      contact.disabled?.should be_falsey
      contact.disable
      contact.disabled?.should be_truthy
    end
  end

  describe "#enabled" do
    it "should be the oposite of #disabled" do
      contact.enabled.should eq(!contact.disabled)
      contact.update_attribute(:disabled, !contact.disabled)
      contact.enabled.should eq(!contact.disabled)
    end
  end

  describe "#disable" do
    it "should change the value" do
      contact.disabled.should be_falsey
      contact.disable
      contact.disabled.should be_truthy
    end
  end

  describe "#enable" do
    it "should change the value" do
      contact.update_attribute(:disabled, true)
      contact.disabled.should be_truthy
      contact.enable
      contact.disabled.should be_falsey
    end

  end

  describe "#set_token" do
    it "should set the token to something random" do
      contact = Contact.new email: email
      contact.token.should be_nil
      contact.save!
      contact.token.should match(/^[0-9a-f]{32}$/)
    end

    it "should not reset the token if it has already been set" do
      contact = Contact.new email: email, token: "pie"
      contact.save!
      contact.token.should eq("pie")
    end
  end

  describe "class method" do
    describe "#build_from_email" do
      it "should build a new contact" do
        contact = Contact.build_from_email(email)
        contact.should be_a_new_record
        contact.email.should eq(email)
        contact.should_not be_disabled
      end

      it "should find the existing contact" do
        Contact.create! email: email, disabled: true
        contact = Contact.build_from_email(email)
        contact.should_not be_a_new_record
        contact.email.should eq(email)
        contact.should_not be_disabled
      end
    end

    describe "#emails" do
      it "should find all active unique emails" do
        contact
        contact2
        Contact.create!(email: "example3@example.com", disabled: true)

        Contact.emails.sort.should eq([contact.email, contact2.email].sort)
      end
    end

    describe "#last_updated_at" do
      it "should find the updated at of the last contact" do
        contact
        contact2.update_attribute(:updated_at, Time.now - 1.year)

        Contact.last_updated_at.to_i.should eq(contact.updated_at.to_i)
      end

      it "should handle an empty list" do
        Contact.last_updated_at.should be_nil
      end
    end

    describe "#add_bulk" do
      it "should split on whitespace, strings, and newlines" do
        Contact.add_bulk("1@example.com,2@example.com 3@example.com\n4@example.com")
        Contact.all.sort.map(&:email).should eq(["1@example.com", "2@example.com", "3@example.com", "4@example.com"])
      end

      it "should deal with duplicates" do
        Contact.add_bulk("1@example.com 1@example.com")
        Contact.count.should eq(1)
      end

      it "should deal with emails that already exist" do
        Contact.create!(email: "1@example.com", disabled: true)
        Contact.add_bulk("1@example.com")
        Contact.count.should eq(1)
        Contact.last.disabled.should be_falsey
      end

      it "should return a count of added emails" do
        Contact.add_bulk("1@example.com bad 1@example.com 2@example.com").should eq(2)
      end
    end
  end
end
