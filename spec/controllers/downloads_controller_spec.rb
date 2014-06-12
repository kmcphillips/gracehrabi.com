require "spec_helper"

describe DownloadsController do
  let(:purchase){ FactoryGirl.create(:purchase) }
  let(:download){ purchase.download }

  describe "GET download" do
    it "should return the file by name" do
      expect(controller).to receive(:send_file).and_return{ controller.render nothing: true }
      get :download, filename: download.filename, token: purchase.token
      expect(response).to be_success
    end

    it "should 404 with a message for a bad token" do
      expect(controller).to receive(:send_file).never
      get :download, filename: download.filename, token: "bad"
      expect(response).to be_not_found
    end

    it "should 404 with a message for a bad filename" do
      expect(controller).to receive(:send_file).never
      get :download, filename: "a.b.z", token: purchase.token
      expect(response).to be_not_found
    end
  end
end
