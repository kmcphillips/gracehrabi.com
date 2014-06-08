require "spec_helper"

describe PurchaseCreateNotificationJob do
  let(:purchase){ FactoryGirl.create(:purchase) }

  describe "#perform" do
    it "should send the purchase created notification email" do
        expect{
          PurchaseCreateNotificationJob.perform(purchase.id)
        }.to change{ ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
