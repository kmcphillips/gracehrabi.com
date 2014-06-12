require "spec_helper"

describe LyricsController do
  let(:lyric){ FactoryGirl.create(:lyric) }

  describe "GET index" do
    it "should be successful" do
      lyric
      get :index
      expect(response).to be_successful
      expect(assigns[:lyrics]).to eq([lyric])
    end
  end

  describe "GET show" do
    it "should be successful" do
      get :show, id: lyric.id
      expect(response).to be_successful
      expect(assigns[:lyric]).to eq(lyric)
    end
  end
end
