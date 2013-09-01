class AddAuthorizedEmails < ActiveRecord::Migration
  def change
    create_table :authorized_emails do |t|
      t.string :email

      t.timestamps
    end

    add_index :authorized_emails, :email
  end
end
