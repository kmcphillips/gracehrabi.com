ActiveAdmin.register Lyric do
  menu priority: 6, parent: "Content"

  config.batch_actions = false

  filter :title
  filter :body

  controller do
    def permitted_params
      params.permit(lyric: [:title, :body])
    end
  end

  index format: :blog, download_links: false do
    column :title do |lyric|
      link_to lyric.title, admin_lyric_path(lyric)
    end
    column :created_at
    default_actions
  end

  show do |lyric|
    attributes_table do
      row :title
      row :body do
        simple_format(lyric.body).html_safe
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :body
    end

    f.actions
  end

end
