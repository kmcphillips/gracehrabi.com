require "spec_helper"

describe SidebarHelper do
  
  describe "#sidebar_sections" do
    let(:result){ double }
    let(:results){ [result] }

    it "should not allow unknown sections and should raise" do
      expect(->{ helper.sidebar_sections(:junk) }).to raise_error(SidebarHelper::SectionError)
    end

    it "should render :events" do
      expect(Event).to receive(:current_and_upcoming).and_return(results)
      expect(results).to receive(:limit).with(5).and_return(results)
      expect(helper).to receive(:render).with(partial: '/shared/sidebar/events')
      helper.sidebar_sections(:events)
      expect(helper.instance_variable_get('@sidebar_events')).to eq(results)
    end

    it "should render :news" do
      expect(Post).to receive(:recent).and_return(results)
      expect(helper).to receive(:render).with(partial: '/shared/sidebar/news')
      helper.sidebar_sections(:news)
      expect(helper.instance_variable_get('@sidebar_posts')).to eq(results)
    end

    it "should render :gallery" do
      expect(Image).to receive(:random_sample).and_return(results)
      expect(helper).to receive(:render).with(partial: '/shared/sidebar/gallery')
      helper.sidebar_sections(:gallery)
      expect(helper.instance_variable_get('@sidebar_images')).to eq(results)
    end

    it "should render :testimonials" do
      expect(Testimonial).to receive(:random).and_return(results)
      expect(helper).to receive(:render).with(partial: '/shared/sidebar/testimonials')
      helper.sidebar_sections(:testimonials)
      expect(helper.instance_variable_get('@sidebar_testimonial')).to eq(results)
    end

    it "should render multiple" do
      expect(Event).to receive(:current_and_upcoming).and_return(results)
      expect(results).to receive(:limit).with(5).and_return(results)
      expect(Post).to receive(:recent).and_return(results)
      expect(helper).to receive(:render).with(partial: '/shared/sidebar/news')
      expect(helper).to receive(:render).with(partial: '/shared/sidebar/events')
      helper.sidebar_sections(:news, :events)
      expect(helper.instance_variable_get('@sidebar_posts')).to_not be_blank
      expect(helper.instance_variable_get('@sidebar_events')).to_not be_blank
    end
  end

end
