class PurchaseCreateNotificationJob < BaseJob
  class << self

    def perform(purchase_id)
      begin
        PurchaseMailer.created(Purchase.find(purchase_id)).deliver
      rescue => e
        ApplicationErrorJob.enqueue("Could not send purchase create notification: #{ e }",
          purchase_id: purchase_id,
          exception: e
        )
      end
    end
  end
end
