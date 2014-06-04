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

  describe "delegate" do
    subject{ purchase }

    its(:shopify_product_id){ should eq(download.shopify_product_id) }
    its(:filename){ should eq(download.filename) }
  end
end
