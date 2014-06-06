class PurchaseCreateNotificationJob < BaseJob
  class << self

    def perform(purchase_id)
      begin
        purchase = Purchase.find(purchase_id)

        raise "Not yet implemented processing for: #{ webhook }"
      rescue => e
        ApplicationErrorJob.enqueue("Could not send purchase create notification: #{ e }",
          purchase_id: purchase_id,
          exception: e
        )
      end
    end
  end
end
