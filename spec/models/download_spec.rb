require 'spec_helper'

describe Download do
  let(:download){ FactoryGirl.create(:download) }

  it "should be valid" do
    expect(download).to be_valid
  end
end
