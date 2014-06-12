ActiveAdmin.register Purchase do
  menu priority: 9, parent: "Sales"

  config.sort_order = "created_at_desc"
  config.batch_actions = false

  actions :all, except: [:edit, :new, :destroy]

  filter :name
  filter :created_at
  filter :email
  filter :token

  controller do
    def permitted_params
      params.permit(purchase: [])
    end
  end

  index format: :blog, download_links: false do
    column :download do |purchase|
      purchase.download.name # TODO: link
    end
    column :name
    column :email
    column :created_at
    default_actions
  end

  show do |purchase|
    attributes_table do
      row :download do
        purchase.download.name # TODO: link
      end
      row :created_at
      row :name
      row :email
      row :address do
        simple_format(purchase.address)
      end
      row :webhook do
        click_to_show simple_format(purchase.webhook.as_hash.to_s)
      end
    end
  end
end
