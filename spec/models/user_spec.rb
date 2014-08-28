require 'spec_helper'

describe User do
  let(:user){ FactoryGirl.create(:user) }

  describe "#authorized?" do
    it "should be true if an authorized email entry is found" do
      FactoryGirl.create(:authorized_email, email: user.email)
      user.authorized?.should be_truthy
    end

    it "should be false if an entry is not found" do
      user.authorized?.should be_falsey
    end
  end

  describe "class method" do

    describe "#find_for_open_id" do
      it "should be tested" do
        skip
      end
    end

  end
end
