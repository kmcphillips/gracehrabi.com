class CreateDownloadRecords < ActiveRecord::Migration
  def change
    create_table :download_records do |t|
      t.integer :download_id
      t.integer :purchase_id
      t.string :ip_address
      t.string :useragent
      t.string :token

      t.timestamps
    end
  end
end
