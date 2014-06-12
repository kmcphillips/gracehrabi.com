require "spec_helper"

describe FrontEndController do
  describe "protected method" do
    before do
      FactoryGirl.create(:testimonial)
    end

    it "should load the testimonial" do
      expect(controller.send(:current_testimonial)).to be_an_instance_of(Testimonial)
    end
  end
end
