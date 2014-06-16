class AddActiveToTestimonial < ActiveRecord::Migration
  def change
    add_column :testimonials, :active, :boolean, default: true
    add_index :testimonials, :active
  end
end
