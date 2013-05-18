require "spec_helper"

describe Jobs::MailingListWeeklyEvents do
  let(:job){ Jobs::MailingListWeeklyEvents.new }
  let(:event){ FactoryGirl.create(:event) }
  let(:contact){ FactoryGirl.create(:contact) }
  let(:events){ [event] }
  
  describe "#initialize" do
    it "should find and set the contacts and events" do
      contacts = [contact]
      Contact.should_receive(:active).and_return(contacts)
      Event.should_receive(:for_mailing_list).with(2.weeks).and_return(events)
      
      job.instance_variable_get('@contacts').should eq(contacts)
      job.instance_variable_get('@events').should eq(events)
    end
  end
  
  describe "#process" do
    let(:contact2){ FactoryGirl.create(:contact) }
    let(:mailer){ mock }
    let(:mailer2){ mock }
    
    it "should do nothing if there are not any events found" do
      Event.stub(:for_mailing_list).and_return([])
      MailingListMailer.should_not_receive(:upcoming_events)
      job.process
    end
    
    it "should deliver to each contact" do
      Event.stub(:for_mailing_list).and_return(events)
      MailingListMailer.should_receive(:upcoming_events).with(contact, events).and_return(mailer)
      MailingListMailer.should_receive(:upcoming_events).with(contact2, events).and_return(mailer2)
      mailer.should_receive(:deliver)
      mailer2.should_receive(:deliver)
      
      job.process
    end
    
    it "should catch delivery errors" do
      Event.stub(:for_mailing_list).and_return(events)
      MailingListMailer.should_receive(:upcoming_events).with(contact, events).and_return(mailer)
      mailer.should_receive(:deliver).and_raise("butts")
      
      job.process
    end
  end
  
end
