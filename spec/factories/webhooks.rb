require Rails.root.join("spec/support/webhook_loader")

FactoryGirl.define do
  factory :webhook do
    body WebhookLoader.new.order_create_webhook_json
    status 'pending'

    trait :mobile do
      body WebhookLoader.new.order_create_mobile_webhook_json
    end
  end
end
