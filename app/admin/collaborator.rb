ActiveAdmin.register Link, as: "Collaborators" do
  menu priority: 5, parent: "Content"

  config.batch_actions = false

  filter :title
  filter :description

  controller do
    def permitted_params
      params.permit(link: [:title, :url, :description])
    end
  end

  index format: :blog, download_links: false do
    column :title do |link|
      link_to link.title, link.url, target: '_blank'
    end
    column :url do |link|
      link_to link.url, link.url, target: '_blank'
    end
    column :description do |link|
      truncate link.description, length: 80, omission: '...'
    end
    column :sort_order
    actions
  end

  show do |link|
    attributes_table do
      row :title
      row :url do
        link_to link.title, link.url, target: '_blank'
      end
      row :sort_order
      row :description do
        simple_format(link.description)
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :url
      f.input :description
      f.input :sort_order
    end

    f.actions
  end

  action_item only: :show do
    link_to("New Collaborator", new_admin_collaborator_path)
  end
end
