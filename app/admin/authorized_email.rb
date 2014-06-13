ActiveAdmin.register AuthorizedEmail do
  menu label: "Authorized Emails", priority: 9

  config.batch_actions = false
  config.per_page = 50

  actions :all, except: [:show]

  filter :email

  controller do
    def permitted_params
      params.permit(authorized_email: [:email])
    end
  end

  index format: :blog, download_links: false do
    column :email
    column :created_at
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :email
    end
    f.actions
  end

end
