require "spec_helper"

describe Webhook do
  let(:webhook){ FactoryGirl.create(:webhook) }

  describe "validations" do
    it "should be valid" do
      expect(webhook).to be_valid
    end
  end
end
