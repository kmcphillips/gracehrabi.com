class AddPermalinkToLyrics < ActiveRecord::Migration
  def change
    add_column :lyrics, :permalink, :string
  end
end
