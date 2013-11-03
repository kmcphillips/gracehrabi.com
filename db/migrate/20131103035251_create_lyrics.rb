class CreateLyrics < ActiveRecord::Migration
  def change
    create_table :lyrics do |t|
      t.string :title
      t.text :body

      t.timestamps
    end

    add_index :lyrics, :title
  end
end
