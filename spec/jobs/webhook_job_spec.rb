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
        WebhookJob.perform(1)
      end

      it "should process the webhook" do
        pending "not implemented yet"
      end
    end
  end
end
