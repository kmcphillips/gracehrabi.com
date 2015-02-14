require 'spec_helper'

describe Event do
  before(:each) do
    @now = Time.now
    @valid_attributes = {:title => "Pie Festival", :description => "So much pie.", :starts_at => @now - 2.days}
    @event = Event.new @valid_attributes
  end

  let(:event){ @event }

  describe "with real events" do
    let(:time){ Time.parse("2014-02-02 02:00:00 -0600") }

    before(:each) do
      Timecop.freeze time

      @upcoming = Event.create! @valid_attributes.merge(:starts_at => time + 3.days)
      @current = Event.create! @valid_attributes.merge(:starts_at => time + 1.hour)
      @past = Event.create! @valid_attributes.merge(:starts_at => time - 2.days)
    end

    describe "scopes" do
      it "should find the upcoming events" do
        Event.upcoming.should == [@upcoming]
      end

      it "should find the current event" do
        Event.current.should == [@current]
      end

      it "should find the past events" do
        Event.past.should == [@past]
      end

      it "should find the events for the mailing list" do
        Event.create! @valid_attributes.merge(publicized: false, starts_at: time + 2.days)
        Event.create! @valid_attributes.merge(starts_at: time + 15.days)
        Event.for_mailing_list.should eq([@current, @upcoming])
        Event.for_mailing_list(1.day).should eq([@current])
      end
    end

    describe "status" do
      it "should know it is upcoming" do
        @upcoming.status.should == "Upcoming"
      end

      it "should know it is current" do
        @current.status.should == "Current"
      end

      it "should know it is past" do
        @past.status.should == "Past"
      end
    end

    describe "current?" do
      it "should know the current event" do
        @current.current?.should be_truthy
      end

      it "should know the others are not current" do
        @past.current?.should be_falsey
        @upcoming.current?.should be_falsey
      end
    end

    describe "upcoming?" do
      it "should know the upcoming event" do
        @upcoming.upcoming?.should be_truthy
      end

      it "should know the others are not upcoming" do
        @past.upcoming?.should be_falsey
        @current.upcoming?.should be_falsey
      end
    end

    describe "past?" do
      it "should know the past event" do
        @past.past?.should be_truthy
      end

      it "should know the others are not past" do
        @upcoming.past?.should be_falsey
        @current.past?.should be_falsey
      end
    end

    after(:each) do
      Event.destroy_all
      Timecop.return
    end
  end

  describe "#display_name" do
    it "should be the title" do
      expect(event.display_name).to eq(event.title)
    end
  end

  describe "#new_facebook" do
    let(:token){ "the_token" }
    let(:new_facebook){ event.new_facebook(token) }

    it "should be the expected event" do
      expect(new_facebook).to be_an_instance_of(Facebook::Event)
      expect(new_facebook.event).to eq(event)
      expect(new_facebook.user_access_token).to eq(token)
    end
  end

  describe "#published_to_facebook?" do
    it "should be false without a date" do
      expect(event.published_to_facebook?).to be_falsey
    end

    it "should be true with a date" do
      event.published_to_facebook_at = Time.now
      expect(event.published_to_facebook?).to be_truthy
    end
  end

  context "class methods" do
    describe "#locations" do
      it "should return a static list for now of location strings" do
        expect(Event.locations).to eq(["Ottawa, ON", "Winnipeg, MB"])
      end
    end
  end
end
