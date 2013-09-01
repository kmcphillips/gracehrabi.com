require "spec_helper"

describe MailingListMailer do
  let(:mailer){ MailingListMailer.send(:new) }
  
  describe "#upcoming_events" do
    it "should be tested" do
      pending
    end
  end
  
  describe "private method" do
    describe "#mailing_list" do
      it "should not return the contacts for test or development env" do
        Contact.should_not_receive(:emails)
        mailer.send(:mailing_list).should eq([])
      end
      
      it "should get the contacts for prod" do
        emails = double
        Contact.should_receive(:emails).and_return(emails)
        Rails.env.stub(:production?).and_return(true)
        mailer.send(:mailing_list).should eq(emails)
      end
    end
  end
end
