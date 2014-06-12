class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :download_id
      t.integer :webhook_id
      t.string :token
      t.string :email
      t.string :name
      t.text :address

      t.timestamps
    end

    add_index :purchases, :webhook_id
    add_index :purchases, :download_id
    add_index :purchases, :token
  end
end
