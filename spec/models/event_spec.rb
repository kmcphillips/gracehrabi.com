require 'spec_helper'

describe Event do
  before(:each) do
    @now = Time.now
    @valid_attributes = {:title => "Pie Festival", :description => "So much pie.", :starts_at => @now - 2.days}
    @event = Event.new @valid_attributes
  end

  describe "scopes" do
    before(:each) do
      t = Time.now
      Time.stub!(:now => t)

      @upcoming = Event.create! @valid_attributes.merge(:starts_at => t + 3.days)
      @current = Event.create! @valid_attributes.merge(:starts_at => t - 1.hour, :ends_at => t + 1.hour)
      @past1 = Event.create! @valid_attributes.merge(:starts_at => t - 1.day)
      @past2 = Event.create! @valid_attributes.merge(:starts_at => t - 3.days, :ends_at => t - 2.days)
    end

    it "should find the upcoming events" do
      Event.upcoming.should == [@upcoming]
    end

    it "should find the current event" do
      Event.current.should == [@current]
    end

    it "should find the past events" do
      Event.past == [@past1, @past2]
    end

    after(:each) do
      Event.destroy_all
    end
  end

  describe "duration" do
    it "should know the length of the event" do
      @event.ends_at = @now - 1.day
      @event.duration.should == 1.day
    end
    
    it "should handle a nil ends_at" do
      @event.duration.should be_nil
    end
  end
end

