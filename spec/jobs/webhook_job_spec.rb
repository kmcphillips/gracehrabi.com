require "spec_helper"

describe WebhookJob do
  before do
    ResqueSpec.reset!
  end

  let(:webhook){ FactoryGirl.create(:webhook) }

  describe "class method" do
    describe "#perform" do
      it "should raise when the webhook is not found" do
        expect(Webhook.all).to be_blank
        expect(ApplicationErrorJob).to receive(:enqueue)
        WebhookJob.perform(0)
      end

      it "should process the webhook" do
        expect(Webhook).to receive(:find).with(webhook.id).and_return(webhook)
        expect(webhook).to receive(:parse)
        expect(ApplicationErrorJob).to receive(:enqueue).never
        WebhookJob.perform(webhook.id)
      end
    end
  end
end
