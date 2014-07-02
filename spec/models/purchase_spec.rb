require 'spec_helper'

describe Purchase do
  let(:purchase){ FactoryGirl.create(:purchase) }
  let(:download){ purchase.download }

  it "should be valid" do
    expect(purchase).to be_valid
  end

  describe "#set_token" do
    it "should not change the token if one exists" do
      before = purchase.token
      purchase.save!
      expect(purchase.token).to eq(before)
      expect(purchase.token).to_not be_blank
    end

    it "should set a new token" do
      purchase = Purchase.new
      expect(purchase.token).to be_blank
      purchase.valid?
      expect(purchase.token).to match(/[a-f0-9]{16}/)
    end
  end

  describe "#record_download" do
    let(:ip_address){ "1.2.3.4" }
    let(:useragent){ "Mosaic 24.1" }
    let(:request){ double(env: {"REMOTE_ADDR" => ip_address, "HTTP_USER_AGENT" => useragent})}

    it "should create a record and return it" do
      expect(ApplicationErrorJob).to_not receive(:enqueue)
      result = purchase.record_download(request)
      expect(result).to be_persisted
      expect(result.ip_address).to eq(ip_address)
      expect(result.useragent).to eq(useragent)
      expect(result.token).to eq(purchase.token)
      expect(result.purchase).to eq(purchase)
      expect(result.download).to eq(download)
    end
  end

  describe "delegate" do
    subject{ purchase }

    its(:shopify_product_id){ should eq(download.shopify_product_id) }
    its(:filename){ should eq(download.filename) }
  end

  describe "callback" do
    let(:purchase){ FactoryGirl.build(:purchase, webhook: nil, token: nil) }

    it "should enqueue an email job after creation" do
      expect(PurchaseCreateNotificationJob).to receive(:enqueue)
      purchase.save!
    end
  end
end
