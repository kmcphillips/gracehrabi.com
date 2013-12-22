require 'spec_helper'

describe Image do

  before(:each) do
    @valid_attributes = {
      :file_file_name => "test.jpg", 
      :file_content_type => "image/jpg", 
      :file_file_size => "12345", 
      :file_updated_at => Time.now, 
      :file_fingerprint => "123094123092093"
      }
  end

  describe "set_sort_order" do
    it "should set the first sort order" do
      i = Image.create!(@valid_attributes)
      i.reload
      i.sort_order.should == 0
    end

    it "should set the next sort order" do
      Image.create!(@valid_attributes)
      i = Image.create!(@valid_attributes)
      i.reload
      i.sort_order.should == 1
    end
    
    it "should allow a valid? check to be called on an image that has not yet been saved" do
      Image.new(@valid_attribute).valid?
    end
    
    it "should allow for the order to be set with new/save rather than create" do
      i = Image.new(@valid_attributes)
      i.save!
      i.reload
      i.sort_order.should == 0
    end
    
    after(:each) do
      Image.destroy_all
    end
  end
  
end

