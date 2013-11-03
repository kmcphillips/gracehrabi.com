require "spec_helper"

describe Facebook::Event do
  let(:event){ FactoryGirl.create(:event) }
  let(:fb_event){ event.new_facebook }

  describe "#save" do
    
  end
end
