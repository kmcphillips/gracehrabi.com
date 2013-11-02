ActiveAdmin.register Event, as: "Show" do
  menu label: "Shows", priority: 2

  config.sort_order = "starts_at_desc"

  filter :title
  filter :starts_at
  filter :publicized

  controller do
    def permitted_params
      params.permit(event: [:title, :description, :publicized, :starts_at, :price, :image, :clear_image, :previous_image_id])
    end
  end

  index format: :blog, download_links: false do
    column :title do |event|
      link_to event.title, admin2_show_path(event)
    end
    # column :description do |event|
    #   truncate event.description, length: 300, omission: '...'
    # end
    column "Start date", :starts_at
    column :in do |event|
      distance_of_time_in_words_to_now(event.starts_at) unless event.starts_at < Time.now
    end
    column :publicized do |event|
      boolean_image event.publicized
    end
    actions do |event|
      render partial: "/admin/events/manitoba_music", object: event
      nil
    end
  end

  show do |event|
    attributes_table do
      row :starts_at
      row :in do
        distance_of_time_in_words_to_now(event.starts_at) unless event.starts_at < Time.now
      end
      row :publicized do
        boolean_image event.publicized  
      end
      row :price do
        number_to_currency(event.price) if event.price
      end
      row :image do
        image_tag(event.inline) if event.image.exists?
      end
      row :description do
        auto_link(simple_format(event.description)).html_safe
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :starts_at, as: :datetime_picker
      f.input :price
      f.input :publicized
    end
    f.inputs do
      f.template.render partial: 'admin2/attached_image', locals: {f: f}
    end
    
    f.actions
  end

end
