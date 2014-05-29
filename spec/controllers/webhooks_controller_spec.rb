require "spec_helper"

describe WebhooksController do
  describe "POST create" do
    it "should not create an invalid webhook" do
      post :create
      expect(Webhook.all).to eq([])
    end
  end
end
