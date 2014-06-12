class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.string :filename
      t.string :path
      t.integer :shopify_product_id
      t.boolean :allow_anonymous, default: false

      t.timestamps
    end

    add_index :downloads, :shopify_product_id
    add_index :downloads, :filename
  end
end
