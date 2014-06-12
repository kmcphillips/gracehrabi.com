require "spec_helper"

describe DownloadHelper do
  let(:purchase){ FactoryGirl.create(:purchase) }
  let(:download){ purchase.download }

  describe "#purchase_url" do
    it "should return the full URL for the download from the purchase" do
      expect(helper.purchase_url(purchase)).to eq("http://test.host/download/#{ purchase.token }/the_album.zip")
    end
  end
end
