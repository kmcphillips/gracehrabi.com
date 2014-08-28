require "spec_helper"

describe MailingListMailer do
  let(:contact){ FactoryGirl.create(:contact) }
  let(:event){ FactoryGirl.create(:event) }
  let(:events){ [event] }

  describe "#upcoming_events" do
    let(:mailer) do
      Timecop.freeze("2014-01-02") do
        MailingListMailer.upcoming_events(contact, events)
      end
    end

    it "should have a correctly formatted mailer" do
      expect(mailer.to).to eq([contact.email])
      expect(mailer.from).to eq(["robot@gracehrabi.com"])
      expect(mailer.subject).to eq("Grace Hrabi: shows for the week of Jan 02, 2014")
      expect(mailer.body).to match(/An Event/)
    end
  end

  describe "private method" do
    let(:mailer){ MailingListMailer.send(:new) }

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
