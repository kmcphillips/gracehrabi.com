class AddTopicToWebhook < ActiveRecord::Migration
  def change
    add_column :webhooks, :topic, :string
    change_column :webhooks, :status, :string, default: 'pending'
    Webhook.update_all(status: 'pending')
  end
end
