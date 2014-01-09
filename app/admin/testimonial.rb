ActiveAdmin.register Testimonial do
  menu priority: 7

  config.batch_actions = false

  filter :body
  filter :name

  controller do
    def permitted_params
      params.permit(testimonial: [:name, :body])
    end
  end

  index format: :blog, download_links: false do
    column :body do |testimonial|
      link_to truncate(testimonial.body, length: 300, omission: '...'), admin_testimonial_path(testimonial)
    end
    column :name
    default_actions
  end

  show do |testimonial|
    attributes_table do
      row :body do
        simple_format(testimonial.body).html_safe
      end
      row :name
    end
  end

  form do |f|
    f.inputs do
      f.input :body
      f.input :name
    end

    f.actions
  end

end
