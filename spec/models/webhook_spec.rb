require "spec_helper"

describe Webhook do
  let(:webhook){ FactoryGirl.create(:webhook) }

  describe "validations" do
    it "should be valid" do
      expect(webhook).to be_valid
    end
  end

  describe "#as_hash" do
    it "should parse the body JSON" do
      expect(webhook.as_hash).to be_an_instance_of(Hash)
    end

    it "should enqueue and return nil" do
      expect(ApplicationErrorJob).to receive(:enqueue)
      webhook.body = "pie"
      expect(webhook.as_hash).to be_nil
    end
  end
end
