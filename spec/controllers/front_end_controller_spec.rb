require "spec_helper"

describe FrontEndController do
  describe "protected method" do
    describe "#current_testimonial" do
      before do
        FactoryGirl.create(:testimonial)
      end

      it "should load the testimonial" do
        expect(controller.send(:current_testimonial)).to be_an_instance_of(Testimonial)
      end
    end

    describe "#upcoming_events" do
      before do
        5.times{ FactoryGirl.create(:event) }
      end

      subject{ controller.send(:upcoming_events) }

      its(:length){ should eq(3) }
      its(:first){ should be_an_instance_of(Event) }
    end

    describe "#recent_posts" do
      before do
        5.times{ FactoryGirl.create(:post) }
      end

      subject{ controller.send(:recent_posts) }

      its(:length){ should eq(3) }
      its(:first){ should be_an_instance_of(Post) }
    end
  end
end
