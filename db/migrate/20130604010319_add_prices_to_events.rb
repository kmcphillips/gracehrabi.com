class AddPricesToEvents < ActiveRecord::Migration
  def up
    add_column :events, :price, :float, default: 0.0
  end

  def down
    remove_column :events, :price
  end
end
