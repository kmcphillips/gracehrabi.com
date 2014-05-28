class AddWebhooksTable < ActiveRecord::Migration
  def change
    create_table :webhooks do |t|
      t.text :body

      t.timestamps
    end

    add_index :webhooks, :created_at
  end
end
