require "spec_helper"

describe WebhooksController do
  describe "POST create" do
    let(:hmac){ "12349817293847987234" }

    before do
      ResqueSpec.reset!
    end

    it "should create a valid webhook in the db and enqueue a job" do
      expect(WebhookJob).to receive(:enqueue)
      expect(Base64).to receive(:encode64).and_return(hmac)
      request.env["HTTP_X_SHOPIFY_HMAC_SHA256"] = hmac

      post :create, {some: "data"}.to_json
      expect(response).to be_successful

      webhook = Webhook.first
      expect(webhook.body).to eq("{\"some\":\"data\"}")
    end

    it "should not create an invalid webhook" do
      expect(WebhookJob).to receive(:enqueue).never
      post :create
      expect(response).to be_successful
      expect(Webhook.all).to be_blank
    end
  end
end
