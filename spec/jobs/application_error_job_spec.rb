require "spec_helper"

describe ApplicationErrorJob do
  before do
    ResqueSpec.reset!
  end

  describe "class method" do
    describe "#perform" do
      it "should send the mailer" do
        expect{
          ApplicationErrorJob.perform("message", key: "value")
        }.to change{ ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end
end
