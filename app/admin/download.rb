ActiveAdmin.register Download do
  menu priority: 5, parent: "Sales"

  config.sort_order = "created_at_desc"
  config.batch_actions = false

  actions :all, except: [:edit, :new, :destroy]

  filter :name
  filter :created_at
  filter :filename
  filter :allow_anonymous

  controller do
    def permitted_params
      params.permit(download: [])
    end
  end

  index format: :blog, download_links: false do
    column :name # TODO: link
    column :allow_anonymous
    column :created_at
    column :total_downloads do |download|
      download.download_records.count
    end
    column :total_sales do |download|
      download.purchases.count
    end
    default_actions
  end

  show do |download|
    attributes_table do
      row :name
      row :file do
        link_to download.filename, file_admin_download_path(download)
      end
      row :allow_anonymous
      row :shopify_product do
        link_to "View product on Shopify", "https://gracehrabi.myshopify.com/admin/products/#{ download.shopify_product_id }"
      end
      # row :image_path
      row :total_downloads do
        download.download_records.count
      end
      row :download_records do
        render partial: 'admin/download_records', object: download.download_records, locals: {show_purchase: true}
      end
    end
  end

  member_action :file do
    send_file(resource.full_path,
      filename: resource.filename,
      disposition: 'attachment'
    )
  end
end
