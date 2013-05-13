class AddEventMailerFields < ActiveRecord::Migration
  def up
    add_column :contacts, :token, :string
    add_index :contacts, :token
    
    add_column :events, :publicized, :boolean, default: true
    add_index :events, :publicized
    
    Event.update_all(publicized: false)
  end

  def down
    remove_column :contacts, :token
    remove_column :events, :publicized
  end
end
