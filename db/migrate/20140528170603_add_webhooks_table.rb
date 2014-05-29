class AddWebhooksTable < ActiveRecord::Migration
  def change
    create_table :webhooks do |t|
      t.text :body
      t.string :status, default: 'new'

      t.timestamps
    end

    add_index :webhooks, :created_at
    add_index :webhooks, :status
  end
end
