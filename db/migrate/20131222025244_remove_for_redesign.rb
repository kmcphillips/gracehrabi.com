class RemoveForRedesign < ActiveRecord::Migration
  def change
    drop_table :medias
    drop_table :tracks
    drop_table :galleries
    remove_column :images, :gallery_id
  end
end
