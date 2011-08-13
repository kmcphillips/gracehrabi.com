class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :email
      t.boolean :disabled, :default => false

      t.timestamps
    end

    add_index :contacts, :disabled
    add_index :contacts, :email
  end

  def self.down
    drop_table :contacts
  end
end
