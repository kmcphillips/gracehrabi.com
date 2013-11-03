class AddFbPublishToEvent < ActiveRecord::Migration
  def change
    add_column :events, :published_to_facebook_at, :datetime
  end
end
