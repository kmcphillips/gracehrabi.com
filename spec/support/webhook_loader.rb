class WebhookLoader
  def order_create_webhook_json
    @order_create_webhook_json ||= File.read(webhook_json_path('order_creation.json'))
  end

  private

  def webhook_json_path(filename)
    File.join(Rails.root, 'spec', 'webhooks', filename)
  end
end
