class AddPricesToEvents < ActiveRecord::Migration
  def up
    add_column :events, :price, :float, default: 0.0
    add_column :events, :manitoba_music_exported_at, :datetime
  end

  def down
    remove_column :events, :price
    remove_column :events, :manitoba_music_exported_at
  end
end
