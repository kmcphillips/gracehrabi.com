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

  describe "#parse" do
    let(:download){ FactoryGirl.create(:download) }

    before do
      download
    end

    it "should send a message and set the error state on failure" do
      pending
    end

    it "should parse and create the webhook" do
      expect(webhook.parse).to be_true
      purchase = webhook.purchases.first
      
      expect(webhook.purchases.count).to eq(1)
      expect(purchase.download).to eq(download)
      expect(purchase.email).to eq("test@example.com")
      expect(purchase.name).to eq("Mister Customer")
      expect(purchase.address).to eq("Mister Shipping\n123 Fake Street Suite 100\nOttawa, Ontario\nA1A1A1")
      expect(purchase.token).to be_present
    end
  end
end
