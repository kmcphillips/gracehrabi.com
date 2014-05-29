require "spec_helper"

describe EventCalendar do
  let(:calendar){ EventCalendar.new("4", 2013) }
  let(:early_calendar){ EventCalendar.new("4", 2008) }
  let(:late_calendar){ EventCalendar.new("4", 2019) }
  
  describe "#month" do
    it "should lookup by name" do
      calendar.month.should eq("April")
    end
  end
  
  describe "#year" do
    it "should be the integer year" do
      calendar.year.should eq(2013)
    end
  end
  
  describe "#next_date" do
    it "should return a date object for the next month" do
      calendar.next_date.should eq(Date.new(2013, 5, 1))
    end

    it "should return nil for a very far date" do
      expect(late_calendar.next_date).to be_nil
      expect(late_calendar.previous_date).to_not be_nil
    end
  end
  
  describe "#previous_date" do
    it "should return a date object for the previous month" do
      calendar.previous_date.should eq(Date.new(2013, 3, 1))
    end

    it "should return nil for a very old date" do
      expect(early_calendar.previous_date).to be_nil
      expect(early_calendar.next_date).to_not be_nil
    end
  end
  
  describe "#weekdays" do
    it "should return an array of strings" do
      calendar.weekdays.should eq(["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"])
    end
  end
  
  describe "#table" do
    subject{ calendar.table }
    
    its("size"){ should eq(5) }
    its("first.first"){ should be_a(EventCalendar::EmptyCell) }
    its("first.last"){ should be_a(EventCalendar::Cell) }
    its("last.first"){ should be_a(EventCalendar::Cell) }
    its("last.last"){ should be_a(EventCalendar::EmptyCell) }
    
    it "should have seven entries in all rows" do
      subject.each do |row|
        row.length.should eq(7)
      end
    end
  end
end
