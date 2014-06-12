class AddTitleToTestimonials < ActiveRecord::Migration
  def change
    add_column :testimonials, :title, :string
  end
end
