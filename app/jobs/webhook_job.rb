class WebhookJob < BaseJob
  class << self

    def perform(webhook_id)
      begin
        webhook = Webhook.find(webhook_id)

        raise "Not yet implemented processing for: #{ webhook }"
      rescue => e
        ApplicationErrorJob.enqueue("Webhook could not be processed: #{ e }",
          webhook_id: webhook_id,
          exception: e
        )
      end
    end

  end
end
