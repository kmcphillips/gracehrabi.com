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

      it "should generate a short list of events" do
        events = controller.send(:upcoming_events)

        expect(events.length).to eq(3)
        events.each do |event|
          expect(event).to be_an_instance_of(Event)
        end
      end
    end

    describe "#recent_posts" do
      before do
        5.times{ FactoryGirl.create(:post) }
      end

      it "should generate a short list of posts" do
        posts = controller.send(:recent_posts)

        expect(posts.length).to eq(3)
        posts.each do |post|
          expect(post).to be_an_instance_of(Post)
        end
      end
    end
  end
end
