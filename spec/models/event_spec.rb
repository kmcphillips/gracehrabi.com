require 'spec_helper'

describe Event do
  before(:each) do
    @now = Time.now
    @event = Event.new :title => "Pie Festival", :description => "So much pie.", :starts_at => @now - 2.days
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

