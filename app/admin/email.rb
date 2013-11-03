ActiveAdmin.register Contact do
  menu label: "Mailing List", priority: 4

  config.batch_actions = false
  config.per_page = 50

  actions :all, except: [:show]

  filter :email
  filter :disabled

  controller do
    def permitted_params
      params.permit(contact: [:email, :disabled])
    end
  end

  index format: :blog, download_links: false do
    column :email
    column :created_at
    column :enabled do |contact|
      boolean_image :enabled?
    end
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :disabled unless f.object.new_record?
    end
    f.actions
  end

  action_item do
    link_to "All Email Addresses", all_admin2_contacts_path
  end

  collection_action :all, method: :get do
    @page_title = "All Email Addresses"
    @emails = Contact.emails
    @date = Contact.last_updated_at
  end

end
