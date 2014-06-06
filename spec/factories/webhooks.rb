require 'support/webhook_loader'

FactoryGirl.define do
  factory :webhook do
    body WebhookLoader.new.order_create_webhook_json
    status 'pending'
  end
end
