class AddDetailsToDownload < ActiveRecord::Migration
  def change
    add_column :downloads, :name, :string
    add_column :downloads, :image_path, :string
  end
end
