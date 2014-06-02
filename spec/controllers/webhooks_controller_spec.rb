require "spec_helper"

describe WebhooksController do
  describe "POST create" do
    let(:hmac){ "12349817293847987234" }

    it "should create a valid webhook in the db" do
      expect(Base64).to receive(:encode64).and_return(hmac)
      request.env["HTTP_X_SHOPIFY_HMAC_SHA256"] = hmac

      post :create, {some: "data"}.to_json
      expect(response).to be_successful

      webhook = Webhook.first
      expect(webhook.body).to eq("{\"some\":\"data\"}")
    end

    it "should not create an invalid webhook" do
      post :create
      expect(response).to be_successful
      expect(Webhook.all).to eq([])
    end
  end
end
