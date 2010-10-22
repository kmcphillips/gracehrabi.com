require 'spec_helper'

describe Track do
  before(:each) do
    @valid_attributes = {:title => "filename", :sort_order => 1, :mp3_file_name => "filename", :mp3_content_type => "audio/mpeg", :mp3_file_size => 1.megabyte, :mp3_updated_at => Time.now}
  end

  it "should set the sort order when there are no others" do
    t = Track.new
    t.valid?
    t.sort_order.should == 1
  end

  it "should increment from the highest object" do
    Track.create! @valid_attributes
    t = Track.new
    t.valid?
    t.sort_order.should == 2
  end

  after(:each) do
    Track.destroy_all
  end

  describe "class methods" do
    describe "window name" do
      it "should form the window name" do
        Track.window_name.should == "_grace_hrabi_player"
      end
    end
  end

  describe "adjacent track" do
    describe "prev" do
      it "should be tested" do
        pending
      end
    end

    describe "next" do
      it "should be tested" do
        pending
      end
    end
  end
end
