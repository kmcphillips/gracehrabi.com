require "spec_helper"

describe SidebarHelper do
  
  describe "#sidebar_sections" do
    it "should not allow unknown sections and should raise" do
      expect(->{ helper.sidebar_sections(:junk) }).to raise_error(SidebarHelper::SectionError)
    end

    it "should return nil" do
      expect(helper.sidebar_sections(:gallery)).to be_nil
    end

    it "should render :events" do
      pending
    end

    it "should render :news" do
      pending
    end

    it "should render :gallery" do
      pending
    end

    it "should render :testimonials" do
      pending
    end
  end

end
