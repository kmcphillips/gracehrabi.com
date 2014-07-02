ActiveAdmin.register Purchase do
  menu priority: 3, parent: "Sales"

  config.sort_order = "created_at_desc"
  config.batch_actions = false

  actions :all, except: [:edit, :destroy]

  filter :name
  filter :created_at
  filter :email
  filter :token

  controller do
    def permitted_params
      params.permit(purchase: [:download_id, :email])
    end

    def action_methods
      if params[:action] == "index"
        super - ['new', :new]
      else
        super
      end
    end
  end

  index format: :blog, download_links: false do
    column :download do |purchase|
      link_to purchase.download.name, admin_download_path(purchase.download)
    end
    column :name
    column :email
    column :total_downloads do |purchase|
      purchase.download_records.count
    end
    column :created_at
    default_actions
  end

  action_item only: :index do
    link_to "Send new download link email", new_admin_purchase_path
  end

  show do |purchase|
    attributes_table do
      row :download do
        link_to purchase.download.name, admin_download_path(purchase.download)
      end
      row :created_at
      row :name
      row :email
      row :address do
        simple_format(purchase.address)
      end
      row :total_downloads do
        purchase.download_records.count
      end
      row :download_records do
        render partial: 'admin/download_records', object: purchase.download_records, locals: {show_purchase: false}
      end
      row :webhook do
        if purchase.webhook
          click_to_show simple_format(purchase.webhook.as_hash.to_s)
        else
          "None"
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :download_id, as: :select, collection: Download.all.map{|d| [d.name, d.id] }, selected: Download.first.id
    end

    f.actions
  end

  member_action :resend, method: :post do
    PurchaseCreateNotificationJob.enqueue(resource.id)
    flash[:notice] = "Email resent"
    redirect_to admin_purchase_path(resource)
  end

  action_item only: :show do
    button_to "Resend Email", resend_admin_purchase_path(resource)
  end
end
