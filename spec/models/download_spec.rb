require 'spec_helper'

describe Download do
  let(:download){ FactoryGirl.create(:download) }

  it "should be valid" do
    expect(download).to be_valid
  end

  describe "#full_path" do
    it "should return the path to the file" do
      expect(download.full_path).to eq("#{ Rails.root }/downloads/the_album-date.zip")
    end
  end
end
